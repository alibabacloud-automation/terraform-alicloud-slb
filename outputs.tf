output "this_slb_id" {
  description = "The ID of the SLB"
  value       = module.slb.slb_id
}

output "this_slb_name" {
  description = "The name of the SLB"
  value       = module.slb.slb_name
}

output "this_slb_address" {
  description = "The IP address of the ELB"
  value       = module.slb.slb_in_address
}

