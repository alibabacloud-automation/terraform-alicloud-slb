variable "profile" {
  default = "default"
}
variable "region" {
  default = "cn-hangzhou"
}

provider "alicloud" {
  region  = var.region
  profile = var.profile
}

data "alicloud_zones" "this" {
  available_instance_type = "ecs.s6-c1m1.small"
  available_resource_creation = "VSwitch"
}

#############################################################
# Data sources to get VPC, vswitch and default security group details
#############################################################
module "vpc" {
  source             = "alibaba/vpc/alicloud"
  create             = true
  vpc_name           = "my_module_vpc"
  vpc_cidr           = "172.16.0.0/16"
  vswitch_name       = "my_module_vswitch"
  vswitch_cidrs      = ["172.16.1.0/24"]
  availability_zones = [data.alicloud_zones.this.ids.0]
}

module "security-group" {
  source      = "alibaba/security-group/alicloud"
  name        = "user-service"
  description = "Security group for user-service with custom rules of source security group."
  vpc_id      = module.vpc.vpc_id
}

// ECS Module
module "ecs_instance" {
  source                      = "alibaba/ecs-instance/alicloud//modules/x86-architecture-general-purpose"
  profile                     = var.profile
  region                      = var.region
  number_of_instances         = 2
  instance_type_family        = "ecs.s6-c1m1"
  instance_type               = "ecs.s6-c1m1.small"
  vswitch_id                  = module.vpc.vswitch_ids[0]
  security_group_ids          = [module.security-group.this_security_group_id]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10
}

// Slb Module
module "slb" {
  source                                    = "../../"
  create                                    = true
  use_existing_slb                          = false
  name                                      = var.name
  internet_charge_type                      = "PayByBandwidth"
  address_type                              = "intranet"
  bandwidth                                 = var.bandwidth
  tags                                      = var.tags
  master_zone_id                            = data.alicloud_zones.this.ids.0
  slave_zone_id                             = data.alicloud_zones.this.ids.0
  vswitch_id = module.vpc.vswitch_ids[0]
}

module "slb2" {
  source            = "../../"
  create            = false
  use_existing_slb  = module.slb.this_slb_name
  existing_slb_id   = module.slb.this_slb_id
  servers_of_default_server_group = [
    {
      server_ids = join(",", module.ecs_instance.this_instance_id)
      weight     = var.weight
      type       = var.type
    }]
}

module "slb3" {
  source  = "../../"
  create  = false
  use_existing_slb  = module.slb.this_slb_name
  existing_slb_id   = module.slb.this_slb_id
  master_slave_server_group_name = "tf-testAccSlbMasterSlaveServerGroupVpc"
  servers_of_master_slave_server_group = [
    {
      server_id   = join(",", module.ecs_instance.this_instance_id)
      port        = var.port
      weight      = var.weight
      server_type = var.server_type
    }]
}

module "slb4" {
  source                    = "../../"
  create                    = false
  use_existing_slb          = module.slb.this_slb_name
  existing_slb_id           = module.slb.this_slb_id
  virtual_server_group_name = var.virtual_server_group_name
  servers_of_virtual_server_group = [
    {
      server_ids = join(",", module.ecs_instance.this_instance_id)
      port       = var.port
      weight     = var.weight
      type       = var.type
    }]
}