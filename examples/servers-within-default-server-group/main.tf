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
# Data sources to get VPC, vswitch and default security group details
#############################################################

data "alicloud_vpcs" "default" {
  is_default = true
}

data "alicloud_security_groups" "default" {
  name_regex = "default"
  vpc_id     = data.alicloud_vpcs.default.ids.0
}

data "alicloud_vswitches" "default" {
  is_default = true
  zone_id    = var.zone_id
}

// If there is no default vswitch, create one.
resource "alicloud_vswitch" "default" {
  count             = length(data.alicloud_vswitches.default.ids) > 0 ? 0 : 1
  availability_zone = var.zone_id
  vpc_id            = data.alicloud_vpcs.default.ids.0
  cidr_block        = cidrsubnet(data.alicloud_vpcs.default.vpcs.0.cidr_block, 4, 15)
}


// ECS Module
module "ecs_instance" {
  source              = "alibaba/ecs-instance/alicloud//modules/x86-architecture-general-purpose"
  profile             = var.profile
  region              = var.region
  number_of_instances = 2
  instance_type_family        = "ecs.g6"
  vswitch_id                  = length(data.alicloud_vswitches.default.ids) > 0 ? data.alicloud_vswitches.default.ids.0 : concat(alicloud_vswitch.default.*.id, [""])[0]
  security_group_ids          = data.alicloud_security_groups.default.ids
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

