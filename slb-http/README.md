Alicloud Load Balancer Instance And HTTP Listener Terraform Module In VPC
=========================================================================

A terraform module to provide load balancer instance and create a HTTP listener in Alicloud.

- The module contains one SLB instance and its HTTP listener.
- You can launch the SLB instance in the VPC by using `vswitch_id`.
- You can add a number of ECS instance into SLB backend server by using `server_ids`.


`NOTE`:
* If `vswitch_id` is set, the `is_internet` only is false
* If slb instance network is intranet, the `internet_charge_type` only is "paybytraffic".


Usage
-----
You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf


         module "tf-slb" {
            source = "alibaba/slb/alicloud/slb-http"

            alicloud_access_key = "${var.alicloud_access_key}"
            alicloud_secret_key = "${var.alicloud_secret_key}"
            region = "${var.region}"

            vswitch_id = "${var.vswitch_id"

            slb_name = "${var.slb_name}"
            backend_port = "${var.backend_port}"
            front_port = "${var.front_port}"
            listener_bandwidth = "${var.listener_bandwidth}"

         }

2. Setting values for the following variables, either through terraform.tfvars or environment variables or -var arguments on the CLI

- alicloud_access_key
- alicloud_secret_key
- region
- slb_name
- vswitch_id
- backend_port
- front_port
- listener_bandwidth


Authors
-------
Created and maintained by He Guimin(@xiaozhu36 heguimin36@163.com)