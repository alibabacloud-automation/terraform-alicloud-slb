//// Output the ID and Name
output "slb_id" {
  value = "${alicloud_slb.this.id}"
}

output "slb_name" {
  value = "${alicloud_slb.this.name}"
}

output "slb_in_address" {
  value = "${alicloud_slb.this.address}"
}
