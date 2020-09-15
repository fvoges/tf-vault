module "xmen_namespace" {
  source         = "../vault_namespace_poc"
  token          = var.token
  namespace_name = "xmen"
  vault_addr     = var.vault_addr
  kv_path        = var.kv_path
  use_kv         = true
  use_policy     = true
  policies = {
    "xmen_policy"       = data.template_file.xmen_policy.rendered
    "xmen_admin_policy" = data.template_file.xmen_admin_policy.rendered
  }
  int_groups = {
    "xmen"              = {
      group_id = vault_identity_group.xmen_group.id
      policies = [ "xmen_policy" ]
    }
    "xmenadmin"         = {
      group_id = vault_identity_group.xmen_admin_group.id
      policies = [ "xmen_admin_policy"]
    }
  }
}

/* Add all namespace based policies here. These are then added to the namespace
in the namespace module with the use of use_policy */
data "template_file" "xmen_policy" {
  template = file("${path.module}/policies/templates/namespace_policy.tpl")
}

data "template_file" "xmen_admin_policy" {
  template = file("${path.module}/policies/templates/namespace_policy.tpl")
}

/* Create an external group for the group that will be admins for
this namespace in LDAP */
resource "vault_identity_group" "xmen_group" {
  name     = "xmen"
  type     = "external"
  policies = [""]
}

resource "vault_identity_group" "xmen_admin_group" {
  name     = "xmenadmin"
  type     = "external"
  policies = [""]
}

resource "vault_identity_group_alias" "xmen-alias" {
  name           = "xmen"
  mount_accessor = vault_ldap_auth_backend.ldap.accessor
  canonical_id   = vault_identity_group.xmen_group.id
}

resource "vault_identity_group_alias" "xmen-admin-alias" {
  name           = "xmenadmin"
  mount_accessor = vault_ldap_auth_backend.ldap.accessor
  canonical_id   = vault_identity_group.xmen_admin_group.id
}
