//// Output the ID and Name
output "slb_id" {
  value = "${alicloud_slb.load_balancer.id}"
}

output "slb_name" {
  value = "${alicloud_slb.load_balancer.name}"
}
