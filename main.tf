module "nodes_api_uat_stockholm" {
  source = "github.com/aeternity/terraform-aws-aenode-deploy?ref=v3.0.1"
  env    = "api_uat"

  static_nodes   = 0
  spot_nodes_min = 2
  spot_nodes_max = 10

  instance_type  = "c6i.xlarge"
  instance_types = ["c6i.xlarge", "c5d.xlarge", "c5.xlarge", "c7i.xlarge"]
  ami_name       = "aeternity-ubuntu-18.04-v1653564902"

  root_volume_size        = 8
  additional_storage      = true
  additional_storage_size = 240

  asg_target_groups = module.lb_uat_stockholm.target_groups

  tags = {
    role  = "aenode"
    env   = "api_uat"
    envid = "api_uat"
  }

  config_tags = {
    bootstrap_version = var.bootstrap_version
    vault_role        = "ae-node"
    vault_addr        = var.vault_addr
    node_config       = "secret/aenode/config/api_uat"
  }

  providers = {
    aws = aws.eu-north-1
  }
}

module "lb_uat_stockholm" {
  source                    = "github.com/aeternity/terraform-aws-api-loadbalancer?ref=v1.4.0"
  env                       = "api_uat"
  fqdn                      = var.lb_fqdn
  dns_zone                  = var.dns_zone
  sc_security_group         = module.nodes_api_uat_stockholm_channels.sg_id
  security_group            = module.nodes_api_uat_stockholm.sg_id
  vpc_id                    = module.nodes_api_uat_stockholm.vpc_id
  subnets                   = module.nodes_api_uat_stockholm.subnets
  internal_api_enabled      = true
  state_channel_api_enabled = true

  providers = {
    aws = aws.eu-north-1
  }
}

module "nodes_api_uat_singapore" {
  source = "github.com/aeternity/terraform-aws-aenode-deploy?ref=v3.0.1"
  env    = "api_uat"

  static_nodes   = 0
  spot_nodes_min = 2
  spot_nodes_max = 10

  instance_type  = "c6i.xlarge"
  instance_types = ["c6i.xlarge", "c5d.xlarge", "c5.xlarge"]
  ami_name       = "aeternity-ubuntu-18.04-v1653564902"

  root_volume_size        = 8
  additional_storage      = true
  additional_storage_size = 240

  asg_target_groups = module.lb_uat_singapore.target_groups

  tags = {
    role  = "aenode"
    env   = "api_uat"
    envid = "api_uat"
  }

  config_tags = {
    bootstrap_version = var.bootstrap_version
    vault_role        = "ae-node"
    vault_addr        = var.vault_addr
    node_config       = "secret/aenode/config/api_uat"
  }

  providers = {
    aws = aws.ap-southeast-1
  }
}

module "nodes_api_uat_stockholm_channels" {
  source = "github.com/aeternity/terraform-aws-aenode-deploy?ref=v3.0.1"
  env    = "api_uat"

  static_nodes   = 1
  spot_nodes_min = 0
  spot_nodes_max = 0

  instance_type  = "c6i.xlarge"
  instance_types = ["c6i.xlarge", "c5d.xlarge", "c5.xlarge", "c7i.xlarge"]
  ami_name       = "aeternity-ubuntu-18.04-v1653564902"

  root_volume_size        = 8
  additional_storage      = true
  additional_storage_size = 240

  asg_target_groups = module.lb_uat_stockholm.target_groups_channels
  subnets           = module.nodes_api_uat_stockholm.subnets
  vpc_id            = module.nodes_api_uat_stockholm.vpc_id

  enable_state_channels = true

  tags = {
    role  = "aenode"
    env   = "api_uat"
    envid = "api_uat"
  }

  config_tags = {
    bootstrap_version = var.bootstrap_version
    vault_role        = "ae-node"
    vault_addr        = var.vault_addr
    node_config       = "secret/aenode/config/api_uat"
  }

  providers = {
    aws = aws.eu-north-1
  }
}

module "lb_uat_singapore" {
  source                    = "github.com/aeternity/terraform-aws-api-loadbalancer?ref=v1.4.0"
  env                       = "api_uat"
  fqdn                      = var.lb_fqdn
  dns_zone                  = var.dns_zone
  security_group            = module.nodes_api_uat_singapore.sg_id
  vpc_id                    = module.nodes_api_uat_singapore.vpc_id
  subnets                   = module.nodes_api_uat_singapore.subnets
  internal_api_enabled      = true
  state_channel_api_enabled = true

  providers = {
    aws = aws.ap-southeast-1
  }
}

module "gateway_uat" {
  source          = "github.com/aeternity/terraform-aws-api-gateway?ref=v3.2.4"
  env             = "api_uat"
  dns_zone        = var.dns_zone
  api_domain      = var.domain
  api_aliases     = var.domain_aliases
  certificate_arn = var.certificate_arn
  lb_fqdn         = var.lb_fqdn
  mdw_fqdn        = var.mdw_fqdn
  headers         = var.headers
  ch_fqdn         = module.lb_uat_stockholm.dns_name
  ae_mdw_fqdn     = var.ae_mdw_fqdn

  api_cache_default_ttl = 1
  mdw_cache_default_ttl = 3
}
