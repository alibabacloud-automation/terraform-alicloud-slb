output "this_rule_id" {
  value       = alicloud_slb_rule.default.id
  description = "The ID of the SLB rule."
}

output "this_rule_name" {
  value       = alicloud_slb_rule.default.name
  description = "The name of the SLB rule."
}
