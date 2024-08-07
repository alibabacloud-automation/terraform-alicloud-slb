resource "alicloud_slb_acl" "this" {
  name       = var.name
  ip_version = var.ip_version
  tags       = var.tags
}

resource "alicloud_slb_acl_entry_attachment" "this" {
  count = length(var.entry_list)

  acl_id  = alicloud_slb_acl.this.id
  entry   = var.entry_list[count.index].entry
  comment = var.entry_list[count.index].comment
}
