locals {
  this_slb_name                     = local.this_slb_id == "" ? "" : concat(data.alicloud_slbs.this.slbs.*.name, [""])[0]
  this_slb_network_type             = local.this_slb_id == "" ? "" : concat(data.alicloud_slbs.this.slbs.*.network_type, [""])[0]
  this_slb_status                   = local.this_slb_id == "" ? "" : concat(data.alicloud_slbs.this.slbs.*.status, [""])[0]
  this_slb_vpc_id                   = local.this_slb_id == "" ? "" : concat(data.alicloud_slbs.this.slbs.*.vpc_id, [""])[0]
  this_slb_vswitch_id               = local.this_slb_id == "" ? "" : concat(data.alicloud_slbs.this.slbs.*.vswitch_id, [""])[0]
  this_slb_address                  = local.this_slb_id == "" ? "" : concat(data.alicloud_slbs.this.slbs.*.address, [""])[0]
  this_slb_tags                     = local.this_slb_id == "" ? "" : concat(data.alicloud_slbs.this.slbs.*.network_type, [{}])[0]
  this_slb_slave_availability_zone  = local.this_slb_id == "" ? "" : concat(data.alicloud_slbs.this.slbs.*.slave_availability_zone, [""])[0]
  this_slb_master_availability_zone = local.this_slb_id == "" ? "" : concat(data.alicloud_slbs.this.slbs.*.master_availability_zone, [""])[0]
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