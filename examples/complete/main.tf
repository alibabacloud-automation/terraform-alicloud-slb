data "alicloud_zones" "default" {
}

data "alicloud_images" "default" {
  name_regex = "^centos_6"
}

data "alicloud_instance_types" "default" {
  availability_zone    = data.alicloud_zones.default.zones[0].id
  instance_type_family = "ecs.c6"
}

module "vpc" {
  source  = "alibaba/vpc/alicloud"
  version = "~> 1.0"

  create             = true
  vpc_cidr           = "172.16.0.0/12"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_zones.default.zones[0].id]
}

module "security_group" {
  source  = "alibaba/security-group/alicloud"
  version = "~> 2.0"

  vpc_id = module.vpc.this_vpc_id
}

module "ecs_instance" {
  source  = "alibaba/ecs-instance/alicloud"
  version = "~> 2.0"

  number_of_instances = 2
  instance_type       = data.alicloud_instance_types.default.instance_types[0].id
  image_id            = data.alicloud_images.default.images[0].id
  vswitch_ids         = module.vpc.this_vswitch_ids
  security_group_ids  = [module.security_group.this_security_group_id]
}

module "slb" {
  source = "../.."

  #alicloud_slb
  create           = true
  use_existing_slb = false

  name                 = var.name
  internet_charge_type = "PayByTraffic"
  address_type         = "intranet"
  vswitch_id           = module.vpc.this_vswitch_ids[0]
  spec                 = var.spec
  bandwidth            = var.bandwidth
  master_zone_id       = data.alicloud_zones.default.zones[0].id
  slave_zone_id        = data.alicloud_zones.default.zones[1].id
  tags                 = var.tags

}

module "slb_backend_server" {
  source = "../.."

  #alicloud_slb
  create           = false
  use_existing_slb = true

  #alicloud_slb_backend_server
  existing_slb_id = module.slb.this_slb_id
  servers_of_default_server_group = [
    {
      server_ids = module.ecs_instance.this_instance_id[0]
      weight     = var.weight
      type       = "ecs"
  }]

}

module "slb_master_slave_server_group" {
  source = "../.."

  #alicloud_slb
  create           = false
  use_existing_slb = true

  #alicloud_slb_master_slave_server_group
  existing_slb_id                = module.slb.this_slb_id
  master_slave_server_group_name = "tf-testacc-master-slave-name"
  servers_of_master_slave_server_group = [
    {
      server_ids  = module.ecs_instance.this_instance_id[0]
      port        = 80
      weight      = 10
      type        = "ecs"
      server_type = "Master"
    },
    {
      server_ids  = module.ecs_instance.this_instance_id[1]
      port        = 80
      weight      = 10
      type        = "ecs"
      server_type = "Slave"
    },
  ]

}

module "slb_server_group" {
  source = "../.."

  #alicloud_slb
  create           = false
  use_existing_slb = true

  #alicloud_slb_server_group
  existing_slb_id           = module.slb.this_slb_id
  virtual_server_group_name = var.virtual_server_group_name
  servers_of_virtual_server_group = [
    {
      server_ids = module.ecs_instance.this_instance_id[1]
      port       = var.port
      weight     = var.weight
      type       = "ecs"
  }]

}
