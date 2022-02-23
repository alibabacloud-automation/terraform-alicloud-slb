output "this_slb_id" {
  description = "The ID of the SLB"
  value       = module.slb.this_slb_id
}

output "this_slb_name" {
  description = "The name of the SLB"
  value       = module.slb.this_slb_name
}

output "this_slb_network_type" {
  description = "The network of the SLB"
  value       = module.slb.this_slb_network_type
}

output "this_slb_status" {
  description = "The status of the SLB"
  value       = module.slb.this_slb_status
}

output "this_slb_vpc_id" {
  description = "The vpc id of the SLB belongs"
  value       = module.slb.this_slb_vpc_id
}

output "this_slb_vswitch_id" {
  description = "The vpc id of the SLB belongs"
  value       = module.slb.this_slb_vswitch_id
}

output "this_slb_address" {
  description = "The IP address of the SLB"
  value       = module.slb.this_slb_address
}

output "this_slb_tags" {
  description = "The tags of the SLB"
  value       = module.slb.this_slb_tags
}

output "this_slb_master_availability_zone" {
  description = "The master availability zone of the SLB belongs"
  value       = module.slb_backend_server.this_slb_master_availability_zone
}

output "this_slb_slave_availability_zone" {
  description = "The slave availability zone of the SLB belongs"
  value       = module.slb_backend_server.this_slb_slave_availability_zone
}

output "this_slb_backend_servers" {
  description = "List of servers attached to default server group."
  value       = module.slb_backend_server.this_slb_backend_servers
}

output "this_slb_master_slave_servers" {
  description = "List of servers attached to master slave server group."
  value       = module.slb_master_slave_server_group.this_slb_master_slave_servers
}

output "this_slb_master_slave_server_group_name" {
  description = "The name of master slave server group"
  value       = module.slb_master_slave_server_group.this_slb_master_slave_server_group_name
}

output "this_slb_master_slave_server_group_id" {
  description = "The ID of master slave server group."
  value       = module.slb_master_slave_server_group.this_slb_master_slave_server_group_id
}

output "this_slb_virtual_servers" {
  description = "List of servers attached to virtual server group."
  value       = module.slb_server_group.this_slb_virtual_servers
}

output "this_slb_virtual_server_group_name" {
  description = "The name of virtual server group"
  value       = module.slb_server_group.this_slb_virtual_server_group_name
}

output "this_slb_virtual_server_group_id" {
  description = "The ID of virtual server group"
  value       = module.slb_server_group.this_slb_virtual_server_group_id
}