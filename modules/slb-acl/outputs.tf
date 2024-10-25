output "this_slb_acl_id" {
  value       = alicloud_slb_acl.this.id
  description = "The ID of the SLB ACL."
}

output "this_slb_acl_name" {
  value       = alicloud_slb_acl.this.name
  description = "The name of the SLB ACL."
}

output "this_slb_acl_ip_version" {
  value       = alicloud_slb_acl.this.ip_version
  description = "The IP version of the SLB ACL."
}

output "this_slb_acl_entry_attachment" {
  value       = alicloud_slb_acl_entry_attachment.this[*].id
  description = "The ID of the SLB ACL entry attachment."
}