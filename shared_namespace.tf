module "shared_namespace" {
  source         = "../vault_namespace_poc"
  token          = var.token
  namespace_name = "shared"
  vault_addr     = var.vault_addr
  kv_path        = var.kv_path
  use_kv         = true
  policies = {
    "shared_policy" = data.template_file.shared_policy.rendered
  }
}

/* no namespace policies -- as this is a shared namespace all policies
are at the root level */
data "template_file" "shared_policy" {
  template = file("${path.module}/policies/templates/shared_policy.tpl")
  vars = {
    namespace_name = "shared"
  }
}

resource "vault_policy" "shared_policy" {
  name   = "shared_policy"
  policy = data.template_file.shared_policy.rendered
}
