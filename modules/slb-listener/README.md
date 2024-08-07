Terraform submodule which creates slb listener resources on Alibaba Cloud.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_slb_listener.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/slb_listener) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_advanced_setting"></a> [advanced\_setting](#input\_advanced\_setting) | The slb listener advanced settings to use on listeners. It's supports fields 'sticky\_session', 'sticky\_session\_type', 'cookie', 'cookie\_timeout', 'gzip', 'persistence\_timeout', 'acl\_status', 'acl\_type', 'acl\_id', 'idle\_timeout' and 'request\_timeout'. | <pre>object({<br>    sticky_session      = optional(string, "off")<br>    sticky_session_type = optional(string, "server")<br>    cookie              = optional(string, null)<br>    cookie_timeout      = optional(number, 86400)<br>    gzip                = optional(string, "false")<br>    persistence_timeout = optional(number, null)<br>    established_timeout = optional(number, null)<br>    acl_status          = optional(string, "off")<br>    acl_type            = optional(string, null)<br>    acl_id              = optional(string, null)<br>    idle_timeout        = optional(number, 15)<br>    request_timeout     = optional(number, 60)<br>  })</pre> | `{}` | no |
| <a name="input_health_check_config"></a> [health\_check\_config](#input\_health\_check\_config) | The slb listener health check settings to use on listeners. It's supports fields 'healthy\_threshold','unhealthy\_threshold','health\_check\_timeout', 'health\_check', 'health\_check\_type', 'health\_check\_connect\_port', 'health\_check\_domain', 'health\_check\_uri', 'health\_check\_http\_code', 'health\_check\_method' and 'health\_check\_interval' | <pre>object({<br>    health_check              = optional(string, "on")<br>    healthy_threshold         = optional(number, 2)<br>    unhealthy_threshold       = optional(number, 3)<br>    health_check_timeout      = optional(number, 5)<br>    health_check_interval     = optional(number, 2)<br>    health_check_connect_port = optional(number, null)<br>    health_check_domain       = optional(string, null)<br>    health_check_uri          = optional(string, "/")<br>    health_check_http_code    = optional(string, "http_2xx")<br>    health_check_type         = optional(string, "tcp")<br>    health_check_method       = optional(string, null)<br>  })</pre> | `{}` | no |
| <a name="input_listeners"></a> [listeners](#input\_listeners) | List of slb listeners. Each item can set all or part fields of alicloud\_slb\_listener resource. | <pre>object({<br>    frontend_port   = number<br>    protocol        = string<br>    backend_port    = optional(number, null)<br>    bandwidth       = optional(number, "-1")<br>    scheduler       = optional(string, "wrr")<br>  })</pre> | <pre>{<br>  "frontend_port": null,<br>  "protocol": null<br>}</pre> | no |
| <a name="input_slb_load_balancer_id"></a> [slb\_load\_balancer\_id](#input\_slb\_load\_balancer\_id) | The load balancer ID used to add one or more listeners. | `string` | `null` | no |
| <a name="input_slb_server_group_id"></a> [slb\_server\_group\_id](#input\_slb\_server\_group\_id) | The load balancer ID used to add one or more listeners. | `string` | `null` | no |
| <a name="input_ssl_certificates_config"></a> [ssl\_certificates\_config](#input\_ssl\_certificates\_config) | SLB Server certificate settings to use on listeners. It's supports fields 'tls\_cipher\_policy', 'server\_certificate\_id' and 'enable\_http2' | <pre>object({<br>    server_certificate_id = optional(string, null)<br>    tls_cipher_policy     = optional(string, null)<br>    enable_http2          = optional(string, "on")<br>  })</pre> | `{}` | no |
| <a name="input_x_forwarded_for_config"></a> [x\_forwarded\_for\_config](#input\_x\_forwarded\_for\_config) | Additional HTTP Header field 'X-Forwarded-For' to use on listeners. It's supports fields 'retrive\_slb\_ip', 'retrive\_slb\_id' and 'retrive\_slb\_proto' | <pre>object({<br>    retrive_slb_ip    = optional(bool, false)<br>    retrive_slb_id    = optional(bool, false)<br>    retrive_slb_proto = optional(bool, false)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_this_slb_listener_frontend_port"></a> [this\_slb\_listener\_frontend\_port](#output\_this\_slb\_listener\_frontend\_port) | The frontend\_port of slb listener |
| <a name="output_this_slb_listener_id"></a> [this\_slb\_listener\_id](#output\_this\_slb\_listener\_id) | The id of slb listener |
<!-- END_TF_DOCS -->