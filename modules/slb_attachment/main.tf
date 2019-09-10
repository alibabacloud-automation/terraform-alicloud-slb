resource "alicloud_slb_attachment" "this" {
  load_balancer_id = var.slb
  instance_ids     = var.instances
}

