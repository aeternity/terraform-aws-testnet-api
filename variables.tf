variable "vault_addr" {
  description = "Vault server URL address"
}

variable "bootstrap_version" {
  default = "v2.6.5"
}

variable "package" {
  default = "https://releases.ops.aeternity.com/aeternity-4.2.0-ubuntu-x86_64.tar.gz"
}

variable "dns_zone" {
  default = "ZSEEAAX46MKWZ"
}

variable "lb_fqdn" {
  default = "lb.testnet.aeternity.io"
}

variable "domain" {
  default = "testnet.aeternity.io"
}

variable "domain_aliases" {
  type    = "list"
  default = ["sdk-testnet.aepps.com", "freya.aeternity.io"]
}
