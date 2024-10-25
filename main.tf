locals {
  create        = var.use_existing_slb ? false : var.create
  create_others = var.use_existing_slb || var.create ? true : false
  this_slb_id   = var.use_existing_slb ? var.existing_slb_id : var.create ? concat(alicloud_slb.this[*].id, [""])[0] : ""
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
        for _, id in split(",", obj["server_ids"]) : {
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
      server_id = backend_servers.value["server_id"]
      weight    = backend_servers.value["weight"]
      type      = backend_servers.value["type"]
    }
  }
}

locals {
  servers_of_master_slave_server_group = flatten(
    [
      for _, obj in var.servers_of_master_slave_server_group : [
        for _, id in split(",", obj["server_ids"]) : {
          server_id   = id
          port        = obj["port"]
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
      server_id   = servers.value["server_id"]
      port        = servers.value["port"]
      weight      = servers.value["weight"]
      type        = servers.value["type"]
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
      server_ids = split(",", servers.value["server_ids"])
      port       = servers.value["port"]
      weight     = lookup(servers.value, "weight", 100)
      type       = lookup(servers.value, "type", "ecs")
    }
  }
}


# acl
module "acl" {
  source = "./modules/slb-acl"
  count  = var.create_slb_acl ? 1 : 0

  name       = var.acl_name
  ip_version = var.acl_ip_version
  entry_list = var.acl_entry_list
  tags       = var.acl_tags
}

locals {
  server_group_id = local.create_others && length(var.servers_of_virtual_server_group) > 0 ? alicloud_slb_server_group.this[0].id : ""
}

# listener
module "listener" {
  source = "./modules/slb-listener"
  count  = var.create_slb_listener ? length(var.listener_config) : 0

  slb_load_balancer_id    = local.this_slb_id
  slb_server_group_id     = length(var.listener_config[count.index].server_group_id) > 0 ? var.listener_config[count.index].server_group_id : local.server_group_id
  listeners               = var.listener_config[count.index].listeners
  health_check_config     = var.listener_config[count.index].health_check_config
  advanced_setting        = var.listener_config[count.index].advanced_setting
  x_forwarded_for_config  = var.listener_config[count.index].x_forwarded_for_config
  ssl_certificates_config = var.listener_config[count.index].ssl_certificates_config
}

# rule
module "rule" {
  source = "./modules/slb-rule"
  count  = var.create_slb_rule ? length(var.rule_config) : 0

  load_balancer_id          = var.rule_config[count.index].load_balancer_id
  frontend_port             = var.rule_config[count.index].frontend_port
  server_group_id           = var.rule_config[count.index].server_group_id
  name                      = var.rule_config[count.index].name
  domain                    = var.rule_config[count.index].domain
  url                       = var.rule_config[count.index].url
  cookie                    = var.rule_config[count.index].cookie
  cookie_timeout            = var.rule_config[count.index].cookie_timeout
  health_check_http_code    = var.rule_config[count.index].health_check_http_code
  health_check_interval     = var.rule_config[count.index].health_check_interval
  health_check_uri          = var.rule_config[count.index].health_check_uri
  health_check_connect_port = var.rule_config[count.index].health_check_connect_port
  health_check_timeout      = var.rule_config[count.index].health_check_timeout
  healthy_threshold         = var.rule_config[count.index].healthy_threshold
  unhealthy_threshold       = var.rule_config[count.index].unhealthy_threshold
  sticky_session            = var.rule_config[count.index].sticky_session
  sticky_session_type       = var.rule_config[count.index].sticky_session_type
  listener_sync             = var.rule_config[count.index].listener_sync
  scheduler                 = var.rule_config[count.index].scheduler
  health_check_domain       = var.rule_config[count.index].health_check_domain
  health_check              = var.rule_config[count.index].health_check

}
