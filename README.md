Alicloud SLB Instance Terraform Module
terraform-alicloud-slb
======================================================

A terraform module which contains a number of configurations of Alicloud SLB.

- The module provider four listeners to the SLB instance.
- You can launch a new SLB in a VPC and Classic.
- If you without VPC or VSwitch, you can create a new one by the module [terraform-alicloud-vpc](https://github.com/alibaba/terraform-alicloud-vpc)


SLB Catalog
-----------

This module contains the following SLB templates for you to use as modules in service Terraform templates.

- [slb-https](https://github.com/alibaba/terraform-alicloud-slb/tree/master/slb-https) - This template will create a SLB instance with a HTTPS listener.

  - Listener front port defaults to 443
  - Listener defaults to turn off health check but can be turned on by setting the health_check variable to "on"
- [slb-http](https://github.com/alibaba/terraform-alicloud-slb/tree/master/slb-http) - This template will create a SLB instance with a HTTP listener.

  - Listener front port defaults to 80
  - Listener defaults to turn off health check but can be turned on by setting the health_check variable to "on"
- [slb-tcp](https://github.com/alibaba/terraform-alicloud-slb/tree/master/slb-tcp) - This template will create a SLB instance with a TCP listener.

  - Listener always turn on health check and default to check using "TCP" way
- [slb-udp](https://github.com/alibaba/terraform-alicloud-slb/tree/master/slb-udp) - This template will create a SLB instance with a udp listener.

  - Listener always turn on health check


`NOTES~`
* These templates default to intranet but can be made internet by setting the is_internet variable to true
* These templates default to "paybytraffic" and have a default bandwidth 1
* If you the intranet, internet charge type does not support "paybybandwidth"
* If you want to launch a new SLB in a VPC, the network type must be intranet that is is_internet = false
* Each template has a default SLB instance name



Usage
-----
- See individual module README's for Usage examples.

Authors
-------
Created and maintained by He Guimin(@xiaozhu heguimin36@163.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/alibaba/terraform-provider)
* [Terraform-Provider-Alicloud Release](https://github.com/alibaba/terraform-provider/releases)
* [Terraform-Provider-Alicloud Latest Docs](http://47.95.33.19:4567/docs/providers/alicloud/)
