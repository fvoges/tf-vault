module "avengers_namespace" {
  source         = "../vault_namespace_poc"
  token          = var.token
  namespace_name = "avengers"
  vault_addr     = var.vault_addr
  kv_path        = var.kv_path
  use_kv         = true
  use_policy     = true

  policies = {
    "avengers_policy"       = data.template_file.avengers_policy.rendered
    "avengers_admin_policy" = data.template_file.avengers_admin_policy.rendered
  }
  int_groups = {
    "avengers"              = {
      group_id = vault_identity_group.avengers_group.id
      policies = [ "avengers_policy" ]
    }
    "avengersadmin"         = {
      group_id = vault_identity_group.avengers_admin_group.id
      policies = [ "avengers_admin_policy" ]
    }
  }
}

/* Add all namespace based policies here. These are then added to the namespace
in the namespace module with the use of use_policy */
data "template_file" "avengers_policy" {
  template = file("${path.module}/policies/templates/namespace_policy.tpl")
}

data "template_file" "avengers_admin_policy" {
  template = file("${path.module}/policies/templates/namespace_policy.tpl")
}

/* Create an external group for the group that will be admins for
this namespace in LDAP */
resource "vault_identity_group" "avengers_group" {
  name     = "avengers"
  type     = "external"
  policies = ["shared_policy"]
}

resource "vault_identity_group" "avengers_admin_group" {
  name     = "avengersadmin"
  type     = "external"
  policies = ["shared_policy"]
}

resource "vault_identity_group_alias" "avengers-alias" {
  name           = "avengers"
  mount_accessor = vault_ldap_auth_backend.ldap.accessor
  canonical_id   = vault_identity_group.avengers_group.id
}

resource "vault_identity_group_alias" "avengers-admin-alias" {
  name           = "avengersadmin"
  mount_accessor = vault_ldap_auth_backend.ldap.accessor
  canonical_id   = vault_identity_group.avengers_admin_group.id
}
