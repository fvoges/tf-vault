resource "vault_generic_secret" "x_example" {
  path = "xmen/secrets/foo"

  data_json = <<EOT
{
  "Cyclops":   "Scott Summers",
  "Beast": "Hank McCoy",
  "Wolverine": "Logan"
}
EOT
}

resource "vault_generic_secret" "a_example" {
  path = "avengers/secrets/foo"

  data_json = <<EOT
{
  "Captain_America":   "Steve Rogers",
  "Hulk": "Bruce Banner",
  "SpiderMan": "Peter Parker"
}
EOT
}

resource "vault_generic_secret" "s_example" {
  path = "shared/secrets/foo"

  data_json = <<EOT
{
  "Iron_Man": "Tony Stark"
}
EOT
}
