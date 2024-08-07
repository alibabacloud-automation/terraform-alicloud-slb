locals {
  this_slb_name                     = var.use_existing_slb ? (concat(data.alicloud_slbs.this.balancers.*.load_balancer_name, [""])[0]) : (var.create ? alicloud_slb.this.*.load_balancer_name[0] : "")
  this_slb_network_type             = var.use_existing_slb ? (concat(data.alicloud_slbs.this.balancers.*.network_type, [""])[0]) : ""
  this_slb_status                   = var.use_existing_slb ? (concat(data.alicloud_slbs.this.balancers.*.status, [""])[0]) : (var.create ? alicloud_slb.this.*.status[0] : "")
  this_slb_vpc_id                   = var.use_existing_slb ? (concat(data.alicloud_slbs.this.balancers.*.vpc_id, [""])[0]) : ""
  this_slb_vswitch_id               = var.use_existing_slb ? (concat(data.alicloud_slbs.this.balancers.*.vswitch_id, [""])[0]) : (var.create ? alicloud_slb.this.*.vswitch_id[0] : "")
  this_slb_address                  = var.use_existing_slb ? (concat(data.alicloud_slbs.this.balancers.*.address, [""])[0]) : (var.create ? alicloud_slb.this.*.address[0] : "")
  this_slb_tags                     = var.use_existing_slb ? (concat(data.alicloud_slbs.this.balancers.*.tags, [""])[0]) : (var.create ? alicloud_slb.this.*.tags[0] : {})
  this_slb_slave_availability_zone  = var.use_existing_slb ? (concat(data.alicloud_slbs.this.balancers.*.slave_zone_id, [""])[0]) : (var.create ? alicloud_slb.this.*.slave_zone_id[0] : "")
  this_slb_master_availability_zone = var.use_existing_slb ? (concat(data.alicloud_slbs.this.balancers.*.master_zone_id, [""])[0]) : (var.create ? alicloud_slb.this.*.master_zone_id[0] : "")
}

data "alicloud_slbs" "this" {
  ids = local.this_slb_id != "" ? [local.this_slb_id] : null
}

output "this_slb_id" {
  description = "The ID of the SLB"
  value       = local.this_slb_id
}

output "this_slb_name" {
  description = "The name of the SLB"
  value       = local.this_slb_name
}

output "this_slb_network_type" {
  description = "The network of the SLB"
  value       = local.this_slb_network_type
}

output "this_slb_status" {
  description = "The status of the SLB"
  value       = local.this_slb_status
}

output "this_slb_vpc_id" {
  description = "The vpc id of the SLB belongs"
  value       = local.this_slb_vpc_id
}

output "this_slb_vswitch_id" {
  description = "The vpc id of the SLB belongs"
  value       = local.this_slb_vswitch_id
}

output "this_slb_address" {
  description = "The IP address of the SLB"
  value       = local.this_slb_address
}

output "this_slb_tags" {
  description = "The tags of the SLB"
  value       = local.this_slb_tags
}

output "this_slb_master_availability_zone" {
  description = "The master availability zone of the SLB belongs"
  value       = local.this_slb_master_availability_zone
}

output "this_slb_slave_availability_zone" {
  description = "The slave availability zone of the SLB belongs"
  value       = local.this_slb_slave_availability_zone
}

output "this_slb_backend_servers" {
  description = "List of servers attached to default server group."
  value       = concat(alicloud_slb_backend_server.this.*.backend_servers, [[]])[0]
}

output "this_slb_master_slave_servers" {
  description = "List of servers attached to master slave server group."
  value       = concat(alicloud_slb_master_slave_server_group.this.*.servers, [[]])[0]
}

output "this_slb_master_slave_server_group_name" {
  description = "The name of master slave server group"
  value       = concat(alicloud_slb_master_slave_server_group.this.*.name, [""])[0]
}

output "this_slb_master_slave_server_group_id" {
  description = "The ID of master slave server group."
  value       = concat(alicloud_slb_master_slave_server_group.this.*.id, [""])[0]
}

output "this_slb_virtual_servers" {
  description = "List of servers attached to virtual server group."
  value       = concat(alicloud_slb_server_group.this.*.servers, [[]])[0]
}

output "this_slb_virtual_server_group_name" {
  description = "The name of virtual server group"
  value       = concat(alicloud_slb_server_group.this.*.name, [""])[0]
}

output "this_slb_virtual_server_group_id" {
  description = "The ID of virtual server group"
  value       = concat(alicloud_slb_server_group.this.*.id, [""])[0]
}

# access control list
output "this_slb_acl_id" {
  value = module.acl[*].this_slb_acl_id
}

output "this_slb_acl_name" {
  value = module.acl[*].this_slb_acl_name
}

output "this_slb_acl_ip_version" {
  value = module.acl[*].this_slb_acl_ip_version
}

output "this_slb_acl_entry_attachment" {
  value = module.acl[*].this_slb_acl_entry_attachment
}

# slb listener
output "this_slb_listener_ids" {
  description = "The id of slb listeners"
  value       = module.listener[*].this_slb_listener_id
}


output "this_slb_listener_frontend_port" {
  description = "The frontend_port of slb listener"
  value       = module.listener[*].this_slb_listener_frontend_port
}


# slb rule
output "this_rule_id" {
  value = module.rule[*].this_rule_id
}

output "this_rule_name" {
  value = module.rule[*].this_rule_id
}
