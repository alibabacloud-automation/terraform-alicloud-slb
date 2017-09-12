Alicloud Load Balancer Instance And HTTPS Listener Terraform Module In VPC
=========================================================================

A terraform module to provide load balancer instance and create a HTTPS listener in Alicloud.

- The module contains one SLB instance and its HTTPS listener.
- You can launch the SLB instance in the VPC by using `vswitch_id`.
- You can add a number of ECS instance into SLB backend server by using `server_ids`.


Module Input Variables
----------------------

The module aim to create one SLB instance and configure a HTTPS listener for it.

#### Common Input vairables

- `alicloud_access_key` - The Alicloud Access Key ID to launch resources
- `alicloud_secret_key` - The Alicloud Access Secret Key to launch resources
- `region` - The region to launch resources

#### VSwitch Input Variables

- `vswitch_id` - VSwitch ID to launch new SLB instance

#### SLB Instance Input Variables

- `slb_name` - The load balancer instance name used to launch a new load balancer - default to "TF_Load_Balancer_HTTPS"
- `is_internet` - Whether the load balancer instance's network type is internet - default to false
- `internet_charge_type` - The charge type of load balancer instance internet network - choices to ["paybytraffic", "paybybandwidth"] - default to "paybytraffic"
- `slb_bandwidth` - The load balancer instance bandwidth - valid in 1-1000Mbps - default to 1

`NOTE`:
* If `vswitch_id` is set, the `is_internet` only is false
* If slb instance network is intranet, the `internet_charge_type` only is "paybytraffic".

#### HTTPS Listener Input Variables

- `backend_port` - The port the service running on the ECS instances will listen on
- `front_port` - The port the service running on the SLB instance will listen on - default to 443
- `listener_bandwidth` - Load balancer listener bandwidth - valid in -1/1-1000Mbps and -1 means there is no limit when using "paybytraffic"
- `scheduler` - Load balancer listener scheduler - choices to ["wrr", "wlc"] - default to "wrr"
- `sticky_session` -  The flag defines whether keep load balancer listener session - choices to ["on", "off"] - default to "off"
- `sticky_session_type` - The way of dealing with listener sticky session - choices to ["insert", "server"]
  "insert" means it is insert by SLB instance and "server" means it will study from backend server - default to "server"
- `cookie_timeout` - Load balancer listener cookie timeout and the valid value 1-86400 in second - default to 86400
- `cookie` - Load balancer listener cookie
- `health_check` - The flag defines whether load balancer listener do health check - choices to ["on", "off"] - default to "off"
- `check_domain` - Health check domain of the load balancer listener
- `check_uri` - Health check uri of the load balancer listener
- `check_connect_port` - Health check connection port of the load balancer listener - valid in -520/1-65535 - default to -520 means using backend server port
- `healthy_threshold`- Healthy threshold of the load balancer listener is used to estimate whether the check result is success - default to 10
- `unhealthy_threshold` - Unhealthy threshold of the load balancer listener is used to estimate whether the check result is fail - default to 10
- `check_timeout` - Health check timeout of the load balancer listener - valid in 1-50 seconds - default to 10
- `check_interval` - Health check interval of the load balancer listener - valid in 1-5 seconds - default to 5
- `check_http_code` - Normal health check http code of the load balancer - choices in ["http_2xx", "http_3xx", "http_4xx", "http_5xx"] - default to "http_2xx"
- `ssl_certificate_id` - The Server Certificate in ECS instance

#### backend servers variables
- `server_ids` - List of ECS instance IDs used to add backend servers for load balancer


Usage
-----
You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf

       module "tf-slb" {
          source = "github.com/terraform-community-modules/terraform-alicloud-slb/slb_https"

          alicloud_access_key = "${var.alicloud_access_key}"
          alicloud_secret_key = "${var.alicloud_secret_key}"
          region = "${var.region}"

          vswitch_id = "${var.vswitch_id"

          slb_name = "${var.slb_name}"
          backend_port = "${var.backend_port}"
          front_port = "${var.front_port}"
          listener_bandwidth = "${var.listener_bandwidth}"
          ssl_certificate_id = "${var.ssl_certificate_id}"

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
- ssl_certificate_id

Module Output Variables
-----------------------

- slb_id - New SLB instance id
- slb_name - New SLB instance name

Authors
-------
Created and maintained by He Guimin(@xiaozhu36  heguimin36@163.com)
