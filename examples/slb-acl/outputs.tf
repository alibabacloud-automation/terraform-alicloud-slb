output "this_slb_acl_id" {
  value       = module.acl.this_slb_acl_id
  description = "The ID of the SLB ACL."
}

output "this_slb_acl_name" {
  value       = module.acl.this_slb_acl_name
  description = "The name of the SLB ACL."
}

output "this_slb_acl_ip_version" {
  value       = module.acl.this_slb_acl_ip_version
  description = "The IP version of the SLB ACL."
}

output "this_slb_acl_entry_attachment" {
  value       = module.acl.this_slb_acl_entry_attachment
  description = "The entry attachment of the SLB ACL."
}