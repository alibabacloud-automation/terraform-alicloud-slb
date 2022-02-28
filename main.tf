locals {
  create        = var.use_existing_slb ? false : var.create
  create_others = var.use_existing_slb || var.create ? true : false
  this_slb_id   = var.use_existing_slb ? var.existing_slb_id : var.create ? concat(alicloud_slb.this.*.id, [""])[0] : ""
  address_type  = var.address_type != "" ? var.address_type : var.internal == false ? "internet" : "intranet"
}

resource "alicloud_slb" "this" {
  count                = local.create ? 1 : 0
  load_balancer_name   = var.name
  internet_charge_type = var.internet_charge_type
  address_type         = local.address_type
  vswitch_id           = var.vswitch_id
  load_balancer_spec   = var.spec == "" ? null : var.spec
  bandwidth            = var.bandwidth
  master_zone_id       = var.master_zone_id == "" ? null : var.master_zone_id
  slave_zone_id        = var.slave_zone_id == "" ? null : var.slave_zone_id
  tags                 = var.tags
}

locals {
  servers_of_default_server_group = flatten(
    [
      for _, obj in var.servers_of_default_server_group : [
        for _, id in split(",", lookup(obj, "server_ids")) : {
          server_id = id
          weight    = lookup(obj, "weight", 100)
          type      = lookup(obj, "type", "ecs")
        }
      ]
    ]
  )
}

resource "alicloud_slb_backend_server" "this" {
  count            = local.create_others && length(var.servers_of_default_server_group) > 0 ? 1 : 0
  load_balancer_id = local.this_slb_id
  dynamic "backend_servers" {
    for_each = local.servers_of_default_server_group
    content {
      server_id = lookup(backend_servers.value, "server_id")
      weight    = lookup(backend_servers.value, "weight")
      type      = lookup(backend_servers.value, "type")
    }
  }
}

locals {
  servers_of_master_slave_server_group = flatten(
    [
      for _, obj in var.servers_of_master_slave_server_group : [
        for _, id in split(",", lookup(obj, "server_ids")) : {
          server_id   = id
          port        = lookup(obj, "port")
          weight      = lookup(obj, "weight", 100)
          type        = lookup(obj, "type", "ecs")
          server_type = lookup(obj, "server_type", null)
        }
      ]
    ]
  )
}

resource "alicloud_slb_master_slave_server_group" "this" {
  count            = local.create_others && length(var.servers_of_master_slave_server_group) > 0 ? 1 : 0
  load_balancer_id = local.this_slb_id
  name             = var.master_slave_server_group_name != "" ? var.master_slave_server_group_name : "${var.name}-master-slave"
  dynamic "servers" {
    for_each = local.servers_of_master_slave_server_group
    content {
      server_id   = lookup(servers.value, "server_id")
      port        = lookup(servers.value, "port")
      weight      = lookup(servers.value, "weight")
      type        = lookup(servers.value, "type")
      server_type = lookup(servers.value, "server_type", null)
    }
  }
}

resource "alicloud_slb_server_group" "this" {
  count            = local.create_others && length(var.servers_of_virtual_server_group) > 0 ? 1 : 0
  load_balancer_id = local.this_slb_id
  name             = var.virtual_server_group_name != "" ? var.virtual_server_group_name : "${var.name}-virtual"
  dynamic "servers" {
    for_each = var.servers_of_virtual_server_group
    content {
      server_ids = split(",", lookup(servers.value, "server_ids"))
      port       = lookup(servers.value, "port")
      weight     = lookup(servers.value, "weight", 100)
      type       = lookup(servers.value, "type", "ecs")
    }
  }
}