module "aws_deploy-api_uat-eu-north-1" {
  source            = "github.com/aeternity/terraform-aws-aenode-deploy?ref=v1.0.0"
  env               = "api_uat"
  bootstrap_version = "${var.bootstrap_version}"
  vault_role        = "ae-node"
  vault_addr        = "${var.vault_addr}"

  static_nodes      = 0
  spot_nodes        = 0
  gateway_nodes_min = 2
  gateway_nodes_max = 30
  dns_zone          = "${var.dns_zone}"
  gateway_dns       = "origin-${var.domain}"

  spot_price       = "0.15"
  instance_type    = "t3.large"
  ami_name         = "aeternity-ubuntu-16.04-v1549009934"
  root_volume_size = 40

  additional_storage      = 1
  additional_storage_size = 30

  aeternity = {
    package = "${var.package}"
  }

  providers = {
    aws = "aws.eu-north-1"
  }
}

module "aws_gateway" {
  source    = "github.com/aeternity/terraform-aws-api-gateway?ref=v1.0.0"
  dns_zone  = "${var.dns_zone}"
  api_dns   = "${var.domain}"
  api_alias = "${var.domain_alias}"

  loadbalancers = [
    "${module.aws_deploy-api_uat-eu-north-1.gateway_lb_dns}",
  ]

  loadbalancers_zones = [
    "${module.aws_deploy-api_uat-eu-north-1.gateway_lb_zone_id}",
  ]

  loadbalancers_regions = [
    "eu-north-1",
  ]

  providers = {
    aws = "aws.us-east-1"
  }
}
