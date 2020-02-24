Alibaba Cloud Load Balancer (SLB) Terraform Module
terraform-alicloud-slb
=====================================================================

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-slb/blob/master/README-CN.md)

Terraform module which creates slb resources on Alibaba Cloud.

These types of resources are supported:

* [Slb Instance](https://www.terraform.io/docs/providers/alicloud/r/slb.html)
* [Slb_Backend_Server](https://www.terraform.io/docs/providers/alicloud/r/slb_backend_server.html)
* [Slb_Master_Slave_Server_Group](https://www.terraform.io/docs/providers/alicloud/r/slb_master_slave_server_group.html)
* [Slb_Server_Group](https://www.terraform.io/docs/providers/alicloud/r/slb_server_group.html)


## Terraform versions

The Module requires Terraform 0.12 and Terraform Provider AliCloud 1.56.0+.

## Usage

```hcl
module "slb" {
  source  = "alibaba/slb/alicloud"
  region  = "cn-beijing"
  profile = "Your-Profile-Name"
  
  ########################
  #attach backend servers#
  ########################
  servers_of_default_server_group = [
    {
      server_ids = "i-bp1xxxxxxxxxx1,i-bp1xxxxxxxxxx2"
      weight     = "90"
      type       = "ecs"
    },
    // Using default value
    {
      server_ids = "i-bp1xxxxxxxxxx3"
    }
  ]
  #############################
  #attach master slave servers#
  #############################
  servers_of_master_slave_server_group = [
    {
      server_ids  = "i-bp1xxxxxxxxxx1"
      port        = "80"
      weight      = "90"
      type        = "ecs"
      server_type = "Master"
    },
    // Using default value
    {
      server_ids  = "i-bp1xxxxxxxxxx2"
      port        = "80"
      server_type = "Slave"
    }
  ]
  ########################
  #attach virtual servers#
  ########################
  servers_of_virtual_server_group = [
    {
      server_ids = "i-bp1xxxxxxxxxx1,i-bp1xxxxxxxxxx2"
      port       = "80"
    },
    {
      server_ids = "eni-bp1xxxxxxxxxx3"
      port       = "8080"
      type       = "eni"
    }
  ]
}

```

## Examples

* [Servers within default server group example](https://github.com/terraform-alicloud-modules/terraform-alicloud-slb/tree/master/examples/servers-within-default-server-group)
* [Servers within master slave server group example](https://github.com/terraform-alicloud-modules/terraform-alicloud-slb/tree/master/examples/servers-within-master-slave-server-group)
* [Servers within virtual server group example](https://github.com/terraform-alicloud-modules/terraform-alicloud-slb/tree/master/examples/servers-within-virtual-server-group)

## Notes

* This module using AccessKey and SecretKey are from `profile` and `shared_credentials_file`.
If you have not set them yet, please install [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) and configure it.

Submit Issues
-------------
If you have any problems when using this module, please opening a [provider issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend to open an issue on this repo.

Authors
-------
Created and maintained by Wang li(@Lexsss, 13718193219@163.com) and He Guimin(@xiaozhu36, heguimin36@163.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

