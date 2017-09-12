Alicloud SLB Instance Terraform Module
terraform-alicloud-slb
======================================================

A terraform module which contains a number of configurations of Alicloud SLB.

- The module provider four listeners to the SLB instance.
- You can launch a new SLB in a VPC and Classic.
- If you without VPC or VSwitch, you can create a new one by the module [tf_alicloud_vpc]()


SLB Catalog
-----------

This module contains the following SLB templates for you to use as modules in service Terraform templates.

- [slb-https](https://github.com/alibaba/terraform-alicloud-slb/slb-https) - This template will create a SLB instance with a HTTPS listener.

  - Listener front port defaults to 443
  - Listener defaults to turn off health check but can be turned on by setting the health_check variable to "on"
- [slb-http](https://github.com/alibaba/terraform-alicloud-slb/slb-http) - This template will create a SLB instance with a HTTP listener.

  - Listener front port defaults to 80
  - Listener defaults to turn off health check but can be turned on by setting the health_check variable to "on"
- [slb-tcp](https://github.com/alibaba/terraform-alicloud-slb/slb-tcp) - This template will create a SLB instance with a TCP listener.

  - Listener always turn on health check and default to check using "TCP" way
- [slb-udp](https://github.com/alibaba/terraform-alicloud-slb/slb-udp) - This template will create a SLB instance with a udp listener.

  - Listener always turn on health check


`Notes~`
1. These templates default to intranet but can be made internet by setting the is_internet variable to true
2. These templates default to "paybytraffic" and have a default bandwidth 1
3. If you the intranet, internet charge type does not support "paybybandwidth"
4. If you want to launch a new SLB in a VPC, the network type must be intranet that is is_internet = false
5. Each template has a default SLB instance name



Usage
-----
- See individual module README's for Usage examples.

Authors
-------
Created and maintained by He Guimin(@xiaozhu heguimin36@163.com)