variable "vault_addr" {
  description = "Vault server URL address"
}

variable "bootstrap_version" {
  default = "v2.10.0"
}

variable "package" {
  default = "https://releases.aeternity.io/aeternity-5.5.3-ubuntu-x86_64.tar.gz"
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

variable "mdw_fqdn" {
  default = "testnet.aeternal.io"
}

variable "headers" {
  default = ["Accept-Encoding", "Origin"]
}

variable "certificate_arn" {
  default = "arn:aws:acm:us-east-1:106102538874:certificate/fd311c12-9e1c-4e98-bc7a-d8f2f80c7247"
}
