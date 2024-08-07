// Output the ID of the slb and new slb listener created
output "this_slb_listener_id" {
  description = "The id of slb listener"
  value       = alicloud_slb_listener.this.id
}

output "this_slb_listener_frontend_port" {
  description = "The frontend_port of slb listener"
  value       = alicloud_slb_listener.this.frontend_port
}
