variable "region" {
  default = "cn-hangzhou"
}
variable "zone_id" {
  default = "cn-hangzhou-h"
}

provider "alicloud" {
  region = var.region
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
  cidr_block        = cidrsubnet(data.alicloud_vpcs.default.vpcs.0.cidr_block, 4, 14)
}


// ECS Module
module "ecs-instance-master" {
  source                      = "alibaba/ecs-instance/alicloud//modules/x86-architecture-general-purpose"
  region                      = var.region
  instance_type_family        = "ecs.g6"
  vswitch_id                  = length(data.alicloud_vswitches.default.ids) > 0 ? data.alicloud_vswitches.default.ids.0 : concat(alicloud_vswitch.default.*.id, [""])[0]
  security_group_ids          = data.alicloud_security_groups.default.ids
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10
}

module "ecs-instance-slave" {
  source                      = "alibaba/ecs-instance/alicloud//modules/x86-architecture-entry-level"
  region                      = var.region
  instance_type_family        = "ecs.g6"
  vswitch_id                  = length(data.alicloud_vswitches.default.ids) > 0 ? data.alicloud_vswitches.default.ids.0 : concat(alicloud_vswitch.default.*.id, [""])[0]
  security_group_ids          = data.alicloud_security_groups.default.ids
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10
}

// Slb Module
module "slb" {
  source = "../../"
  region = var.region
  servers_of_master_slave_server_group = [
    {
      server_ids  = join(",", module.ecs-instance-master.this_instance_id)
      port        = "80"
      weight      = "100"
      type        = "ecs"
      server_type = "Master"
    },
    {
      server_ids  = join(",", module.ecs-instance-slave.this_instance_id)
      port        = "80"
      weight      = "90"
      server_type = "Slave"
    },
  ]
}

