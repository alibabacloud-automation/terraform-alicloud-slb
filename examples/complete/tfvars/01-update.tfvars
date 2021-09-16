##############################################################
#variables for alicloud_slb
##############################################################
name = "tf-module-slb-test-update"
virtual_server_group_name = "tf-server-group-update-001"
weight = 50
bandwidth = 20
port = 80
tags = {
  tag_g = 7
  tag_h = 8
  tag_i = 9
  tag_j = 10
}
server_type = "Master"
type = "eni"
