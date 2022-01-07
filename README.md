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

## Usage

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

## Examples

* [Servers within default server group example](https://github.com/terraform-alicloud-modules/terraform-alicloud-slb/tree/master/examples/servers-within-default-server-group)
* [Servers within master slave server group example](https://github.com/terraform-alicloud-modules/terraform-alicloud-slb/tree/master/examples/servers-within-master-slave-server-group)
* [Servers within virtual server group example](https://github.com/terraform-alicloud-modules/terraform-alicloud-slb/tree/master/examples/servers-within-virtual-server-group)

## Notes
From the version v1.7.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/slb"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.6.1:

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

If you want to upgrade the module to 1.7.0 or higher in-place, you can define a provider which same region with
previous region:

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
or specify an alias provider with a defined region to the module using `providers`:

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

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

Submit Issues
-------------
If you have any problems when using this module, please opening a [provider issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend to open an issue on this repo.

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

