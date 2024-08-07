variable "profile" {
  default = "default"
}
variable "region" {
  default = "cn-hangzhou"
}
variable "zone_id" {
  default = "cn-hangzhou-h"
}

provider "alicloud" {
  region  = var.region
  profile = var.profile
}

#############################################################
# create VPC, vswitch and security group
#############################################################
resource "alicloud_vpc" "default" {
  vpc_name   = "tf_module"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "default" {
  vpc_id     = alicloud_vpc.default.id
  cidr_block = "172.16.0.0/21"
  zone_id    = var.zone_id
}

module "security_group" {
  source  = "alibaba/security-group/alicloud"
  profile = var.profile
  region  = var.region
  vpc_id  = alicloud_vpc.default.id
  version = "~> 2.0"
}

// ECS Module
module "ecs_instance" {
  source              = "alibaba/ecs-instance/alicloud//modules/x86-architecture-general-purpose"
  profile             = var.profile
  region              = var.region
  number_of_instances = 2

  instance_type_family        = "ecs.g6"
  vswitch_id                  = alicloud_vswitch.default.id
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10
}

// Slb Module
module "slb" {
  source  = "../../"
  region  = var.region
  profile = var.profile
  servers_of_default_server_group = [
    {
      server_ids = join(",", module.ecs_instance.this_instance_id)
      weight     = "100"
      type       = "ecs"
    },
  ]
}

