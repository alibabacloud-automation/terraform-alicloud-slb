module "acl" {
  source = "../.."

  create = false

  create_slb_acl = true
  acl_name       = var.acl_name
  acl_entry_list = var.acl_entry_list
  acl_ip_version = var.acl_ip_version
}

