output "this_slb_acl_id" {
  value = alicloud_slb_acl.this.id
}

output "this_slb_acl_name" {
  value = alicloud_slb_acl.this.name
}

output "this_slb_acl_ip_version" {
  value = alicloud_slb_acl.this.ip_version
}

output "this_slb_acl_entry_attachment" {
  value = alicloud_slb_acl_entry_attachment.this[*].id
}