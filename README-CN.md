Alibaba Cloud Load Balancer (SLB) Terraform Module
terraform-alicloud-slb
=====================================================================

本 Module 用于在阿里云创建负载均衡相关资源. 

本 Module 支持创建以下资源:

* [Slb Instance](https://www.terraform.io/docs/providers/alicloud/r/slb.html)
* [Slb_Backend_Server](https://www.terraform.io/docs/providers/alicloud/r/slb_backend_server.html)
* [Slb_Master_Slave_Server_Group](https://www.terraform.io/docs/providers/alicloud/r/slb_master_slave_server_group.html)
* [Slb_Server_Group](https://www.terraform.io/docs/providers/alicloud/r/slb_server_group.html)


## Terraform 版本

本 Module 要求使用 Terraform 0.12 和 阿里云 Provider 1.56.0+。

## 用法

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

## 示例

* [挂载到默认服务器组示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-slb/tree/master/examples/servers-within-default-server-group)
* [挂载到主备服务器组示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-slb/tree/master/examples/servers-within-master-slave-server-group)
* [挂载到虚拟服务器组示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-slb/tree/master/examples/servers-within-virtual-server-group)

## 注意事项

* 本 Module 使用的 AccessKey 和 SecretKey 可以直接从 `profile` 和 `shared_credentials_file` 中获取。如果未设置，可通过下载安装 [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) 后进行配置.

提交问题
-------
如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

作者
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)