terraform {
  required_providers {
    template = "~> 2.1"
    vault    = "~> 2.10"
  }
}

provider "vault" {
  address = var.vault_addr
  token   = var.token
}

/* Root Namespace Policy */
data "template_file" "root_policy" {
  template = file("${path.module}/policies/templates/root_namespace_policy.tpl")
}

resource "vault_policy" "root_policy" {
  name   = "root_policy"
  policy = data.template_file.root_policy.rendered
}

/* Admin Policy */
resource "vault_policy" "admin_policy" {
  name   = "admin_policy"
  policy = file("${path.module}/policies/admin_policy.hcl")
}

resource "vault_identity_group" "admin_group" {
  name     = "VaultAdmin"
  type     = "external"
  policies = [ "admin_policy" ]
}

resource "vault_identity_group_alias" "admin-alias" {
  name           = "vaultadmin"
  mount_accessor = vault_ldap_auth_backend.ldap.accessor
  canonical_id   = vault_identity_group.admin_group.id
}

# resource "vault_identity_group_policies" "pols" {
#   policies  = [ "" ]
#   group_id  = vault_identity_group.admin_group.id
#   exclusive = true
# }
