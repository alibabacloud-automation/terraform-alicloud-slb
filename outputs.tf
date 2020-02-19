output "this_slb_id" {
  description = "The ID of the SLB"
  value       = concat(alicloud_slb.this.*.id, [""])[0]
}

output "this_slb_name" {
  description = "The name of the SLB"
  value       = concat(alicloud_slb.this.*.name, [""])[0]
}

output "this_slb_address" {
  description = "The IP address of the SLB"
  value       = concat(alicloud_slb.this.*.address, [""])[0]
}

output "this_slb_backend_servers" {
  description = "List of slb attached backend servers"
  value       = concat(alicloud_slb_backend_server.this.*.backend_servers, [[]])[0]
}

output "this_slb_master_slave_servers" {
  description = "List of slb master slave servers"
  value       = concat(alicloud_slb_master_slave_server_group.this.*.servers, [[]])[0]
}

output "this_slb_virtual_servers" {
  description = "List of slb virtual servers"
  value       = concat(alicloud_slb_server_group.this.*.servers, [[]])[0]
}