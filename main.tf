module "nodes_api_uat_stockholm" {
  source            = "github.com/aeternity/terraform-aws-aenode-deploy?ref=v2.3.1"
  env               = "api_uat"
  envid             = "api_uat"
  bootstrap_version = var.bootstrap_version
  vault_role        = "ae-node"
  vault_addr        = var.vault_addr

  static_nodes   = 0
  spot_nodes_min = 2
  spot_nodes_max = 10

  spot_price    = "0.15"
  instance_type = "t3.large"
  ami_name      = "aeternity-ubuntu-16.04-v1549009934"

  additional_storage      = true
  additional_storage_size = 30
  snapshot_filename       = "mnesia_uat_v-1_latest.tgz"

  asg_target_groups = module.lb_uat_stockholm.target_groups

  aeternity = {
    package = var.package
  }

  providers = {
    aws = "aws.eu-north-1"
  }
}

module "nodes_api_uat_singapore" {
  source            = "github.com/aeternity/terraform-aws-aenode-deploy?ref=v2.3.1"
  env               = "api_uat"
  envid             = "api_uat"
  bootstrap_version = var.bootstrap_version
  vault_role        = "ae-node"
  vault_addr        = var.vault_addr

  static_nodes   = 0
  spot_nodes_min = 2
  spot_nodes_max = 10

  spot_price    = "0.15"
  instance_type = "t3.large"
  ami_name      = "aeternity-ubuntu-16.04-v1549009934"

  additional_storage      = true
  additional_storage_size = 30
  snapshot_filename       = "mnesia_uat_v-1_latest.tgz"

  asg_target_groups = module.lb_uat_stockholm.target_groups

  aeternity = {
    package = var.package
  }

  providers = {
    aws = "aws.ap-southeast-1"
  }
}

module "lb_uat_stockholm" {
  source                    = "github.com/aeternity/terraform-aws-api-loadbalancer?ref=v1.2.0"
  env                       = "api_uat"
  fqdn                      = var.lb_fqdn
  dns_zone                  = var.dns_zone
  security_group            = module.nodes_api_uat_stockholm.sg_id
  vpc_id                    = module.nodes_api_uat_stockholm.vpc_id
  subnets                   = module.nodes_api_uat_stockholm.subnets
  internal_api_enabled      = true
  state_channel_api_enabled = true

  providers = {
    aws = "aws.eu-north-1"
  }
}

module "gateway_uat" {
  source          = "github.com/aeternity/terraform-aws-api-gateway?ref=v3.1.0"
  env             = "api_uat"
  dns_zone        = var.dns_zone
  api_domain      = var.domain
  api_aliases     = var.domain_aliases
  certificate_arn = aws_acm_certificate_validation.cert.certificate_arn
  lb_fqdn         = var.lb_fqdn
  mdw_fqdn        = var.mdw_fqdn
}
