output "this_slb_id" {
  description = "The ID of the SLB"
  value       = module.slb.this_slb_id
}

output "this_slb_name" {
  description = "The name of the SLB"
  value       = module.slb.this_slb_name
}

output "this_slb_address" {
  description = "The IP address of the SLB"
  value       = module.slb.this_slb_address
}

output "this_slb_backend_servers" {
  description = "List of slb attached backend servers"
  value       = module.slb.this_slb_backend_servers
}

output "this_slb_master_slave_servers" {
  description = "List of slb master slave servers"
  value       = module.slb.this_slb_master_slave_servers
}

output "this_slb_virtual_servers" {
  description = "List of slb virtual servers"
  value       = module.slb.this_slb_virtual_servers
}