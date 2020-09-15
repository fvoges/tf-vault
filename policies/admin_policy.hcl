# FIXME: adjust permissions to minimum necessary
path "*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]

}

# Manage namespaces
path "sys/namespaces/*" {
   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Manage auth methods broadly across Vault
path "auth/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Create, update, and delete auth methods
path "sys/auth/*"
{
  #capabilities = ["create", "update", "delete", "sudo"]
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# List auth methods
path "sys/auth"
{
  #capabilities = ["read"]
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# List existing policies
path "sys/policies/acl"
{
  #capabilities = ["list"]
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Create and manage ACL policies
path "sys/policies/acl/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# List, create, update, and delete key/value secrets
path "secret/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Manage secrets engines
path "sys/mounts/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# List existing secrets engines.
path "sys/mounts"
{
  #capabilities = ["read"]
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Read health checks
path "sys/health"
{
  #capabilities = ["read", "sudo"]
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

