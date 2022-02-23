Alibaba Cloud Load Balancer (SLB) Terraform Module
terraform-alicloud-slb
=====================================================================

本 Module 用于在阿里云创建负载均衡相关资源. 

本 Module 支持创建以下资源:

* [Slb Instance](https://www.terraform.io/docs/providers/alicloud/r/slb.html)
* [Slb_Backend_Server](https://www.terraform.io/docs/providers/alicloud/r/slb_backend_server.html)
* [Slb_Master_Slave_Server_Group](https://www.terraform.io/docs/providers/alicloud/r/slb_master_slave_server_group.html)
* [Slb_Server_Group](https://www.terraform.io/docs/providers/alicloud/r/slb_server_group.html)

## 用法

```hcl
module "slb" {
  source  = "alibaba/slb/alicloud"
  
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
本Module从版本v1.7.0开始已经移除掉如下的 provider 的显式设置：

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/slb"
}
```

如果你依然想在Module中使用这个 provider 配置，你可以在调用Module的时候，指定一个特定的版本，比如 1.6.1:

```hcl
module "slb" {
  source  = "alibaba/slb/alicloud"
  version     = "1.6.1"
  region      = "cn-beijing"
  profile     = "Your-Profile-Name"
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
  // ...
}
```

如果你想对正在使用中的Module升级到 1.7.0 或者更高的版本，那么你可以在模板中显式定义一个相同Region的provider：
```hcl
provider "alicloud" {
  region  = "cn-beijing"
  profile = "Your-Profile-Name"
}
module "slb" {
  source  = "alibaba/slb/alicloud"
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
  // ...
}
```
或者，如果你是多Region部署，你可以利用 `alias` 定义多个 provider，并在Module中显式指定这个provider：

```hcl
provider "alicloud" {
  region  = "cn-beijing"
  profile = "Your-Profile-Name"
  alias   = "bj"
}
module "slb" {
  source  = "alibaba/slb/alicloud"
  providers = {
    alicloud = alicloud.bj
  }
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
  // ...
}
```

定义完provider之后，运行命令 `terraform init` 和 `terraform apply` 来让这个provider生效即可。

更多provider的使用细节，请移步[How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform 版本

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

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