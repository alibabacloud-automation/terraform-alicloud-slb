This submodule is used to create an SLB Rule instance with Rule.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.123.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.123.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_slb_rule.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/slb_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cookie"></a> [cookie](#input\_cookie) | The cookie configured on the server. It is mandatory when `sticky_session` is `on` and `sticky_session_type` is `server`. Otherwise, it will be ignored. Valid value：String in line with RFC 2965, with length being 1- 200. It only contains characters such as ASCII codes, English letters and digits instead of the comma, semicolon or spacing, and it cannot start with $. | `string` | `"cookie_test"` | no |
| <a name="input_cookie_timeout"></a> [cookie\_timeout](#input\_cookie\_timeout) | Cookie timeout. It is mandatory when sticky\_session is `on` and sticky\_session\_type is `insert`. Otherwise, it will be ignored. Valid value range: [1-86400] in seconds. | `number` | `100` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Domain name of the forwarding rule. It can contain letters a-z, numbers 0-9, hyphens (-), and periods (.), and wildcard characters. | `string` | `"*.aliyun.com"` | no |
| <a name="input_frontend_port"></a> [frontend\_port](#input\_frontend\_port) | The frontend port of SLB listener. | `string` | `null` | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | Whether to enable health check. Valid values are `on` and `off`. TCP and UDP listener's HealthCheck is always on, so it will be ignore when launching TCP or UDP listener. This parameter is required and takes effect only when ListenerSync is set to off. | `string` | `"on"` | no |
| <a name="input_health_check_connect_port"></a> [health\_check\_connect\_port](#input\_health\_check\_connect\_port) | Port used for health check. Valid value range: [1-65535]. Default to `None` means the backend server port is used. | `string` | `"20"` | no |
| <a name="input_health_check_domain"></a> [health\_check\_domain](#input\_health\_check\_domain) | Domain name used for health check. When it used to launch TCP listener, health\_check\_type must be `http`. Its length is limited to 1-80 and only characters such as letters, digits, ‘-‘ and ‘.’ are allowed. When it is not set or empty, Server Load Balancer uses the private network IP address of each backend server as Domain used for health check. | `string` | `"test"` | no |
| <a name="input_health_check_http_code"></a> [health\_check\_http\_code](#input\_health\_check\_http\_code) | Regular health check HTTP status code. Multiple codes are segmented by “,”. It is required when health\_check is on. Default to `http_2xx`. Valid values are: `http_2xx`, `http_3xx`, `http_4xx` and `http_5xx`. | `string` | `"http_2xx"` | no |
| <a name="input_health_check_interval"></a> [health\_check\_interval](#input\_health\_check\_interval) | Time interval of health checks. It is required when `health_check` is on. Valid value range: [1-50] in seconds. Default to 2. | `number` | `2` | no |
| <a name="input_health_check_timeout"></a> [health\_check\_timeout](#input\_health\_check\_timeout) | Maximum timeout of each health check response. It is required when `health_check` is on. Valid value range: [1-300] in seconds. Default to 5. Note: If `health_check_timeout` < `health_check_interval`, its will be replaced by `health_check_interval`. | `number` | `30` | no |
| <a name="input_health_check_uri"></a> [health\_check\_uri](#input\_health\_check\_uri) | URI used for health check. When it used to launch TCP listener, health\_check\_type must be `http`. Its length is limited to 1-80 and it must start with /. Only characters such as letters, digits, ‘-’, ‘/’, ‘.’, ‘%’, ‘?’, #’ and ‘&’ are allowed. | `string` | `"/test"` | no |
| <a name="input_healthy_threshold"></a> [healthy\_threshold](#input\_healthy\_threshold) | Threshold determining the result of the health check is success. It is required when `health_check` is on. Valid value range: [1-10] in seconds. Default to 3. | `number` | `3` | no |
| <a name="input_listener_sync"></a> [listener\_sync](#input\_listener\_sync) | Indicates whether a forwarding rule inherits the settings of a health check , session persistence, and scheduling algorithm from a listener. Default to on. | `string` | `"off"` | no |
| <a name="input_load_balancer_id"></a> [load\_balancer\_id](#input\_load\_balancer\_id) | The ID of SLB load balancer. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of slb rule. | `string` | `null` | no |
| <a name="input_scheduler"></a> [scheduler](#input\_scheduler) | Scheduling algorithm, Valid values are `wrr`, `rr` and `wlc`. Default to `wrr`. This parameter is required and takes effect only when ListenerSync is set to `off`. | `string` | `"rr"` | no |
| <a name="input_server_group_id"></a> [server\_group\_id](#input\_server\_group\_id) | The ID of SLB server group. | `string` | `null` | no |
| <a name="input_sticky_session"></a> [sticky\_session](#input\_sticky\_session) | Whether to enable session persistence, Valid values are `on` and `off`. Default to `off`. This parameter is required and takes effect only when ListenerSync is set to `off`. | `string` | `"on"` | no |
| <a name="input_sticky_session_type"></a> [sticky\_session\_type](#input\_sticky\_session\_type) | Mode for handling the cookie. If sticky\_session is `on`, it is mandatory. Otherwise, it will be ignored. Valid values are insert and server. insert means it is inserted from Server Load Balancer; server means the Server Load Balancer learns from the backend server. | `string` | `"server"` | no |
| <a name="input_unhealthy_threshold"></a> [unhealthy\_threshold](#input\_unhealthy\_threshold) | Threshold determining the result of the health check is fail. It is required when `health_check` is on. Valid value range: [1-10] in seconds. Default to 3. | `number` | `3` | no |
| <a name="input_url"></a> [url](#input\_url) | Domain of the forwarding rule. It must be 2-80 characters in length. Only letters a-z, numbers 0-9, and characters '-' '/' '?' '%' '#' and '&' are allowed. URLs must be started with the character '/', but cannot be '/' alone. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_this_rule_id"></a> [this\_rule\_id](#output\_this\_rule\_id) | n/a |
| <a name="output_this_rule_name"></a> [this\_rule\_name](#output\_this\_rule\_name) | n/a |
<!-- END_TF_DOCS -->