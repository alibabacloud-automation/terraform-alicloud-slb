# Load Balancer Instance variables
name      = "update-tf-testacc-slb-name"
spec      = "slb.s2.medium"
bandwidth = 20
tags = {
  Name = "updateSLB"
}

# Load Balancer Instance attachment
port                      = 90
weight                    = 20
virtual_server_group_name = "update-tf-testacc-server-group-name"