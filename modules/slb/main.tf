resource "alicloud_slb" "this" {
  name                 = var.name
  internet_charge_type = var.internet_charge_type
  internet             = var.internal
  vswitch_id           = var.vswitch_id
  specification        = var.spec
  bandwidth            = var.bandwidth
}

