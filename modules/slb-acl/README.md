Terraform submodule to create access control list for the load balancer in Alibaba Cloud.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.162.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.162.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_slb_acl.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/slb_acl) | resource |
| [alicloud_slb_acl_entry_attachment.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/slb_acl_entry_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_entry_list"></a> [entry\_list](#input\_entry\_list) | A list of entry (IP addresses or CIDR blocks) to be added. At most 50 etnry can be supported in one resource. It contains two sub-fields as: entry(IP addresses or CIDR blocks), comment(the comment of the entry) | <pre>list(object({<br>    entry   = string<br>    comment = optional(string, null)<br>  }))</pre> | n/a | yes |
| <a name="input_ip_version"></a> [ip\_version](#input\_ip\_version) | The IP Version of access control list is the type of its entry (IP addresses or CIDR blocks). It values ipv4/ipv6. Our plugin provides a default ip\_version: ipv4. | `string` | `"ipv4"` | no |
| <a name="input_name"></a> [name](#input\_name) | the Name of the access control list. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_this_slb_acl_entry_attachment"></a> [this\_slb\_acl\_entry\_attachment](#output\_this\_slb\_acl\_entry\_attachment) | n/a |
| <a name="output_this_slb_acl_id"></a> [this\_slb\_acl\_id](#output\_this\_slb\_acl\_id) | n/a |
| <a name="output_this_slb_acl_ip_version"></a> [this\_slb\_acl\_ip\_version](#output\_this\_slb\_acl\_ip\_version) | n/a |
| <a name="output_this_slb_acl_name"></a> [this\_slb\_acl\_name](#output\_this\_slb\_acl\_name) | n/a |
<!-- END_TF_DOCS -->