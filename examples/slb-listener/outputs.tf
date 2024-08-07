output "this_slb_id" {
  description = "The ID of the load balancer"
  value       = module.slb_listener.this_slb_id
}

output "this_slb_listener_ids" {
  description = "The id of slb listeners"
  value       = module.slb_listener.this_slb_listener_ids
}