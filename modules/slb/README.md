# alicloud_slb

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| vswitch_id | The vswitch id used to launch load balancer | string | - | no |
| name | The name of a new load balancer | string | module-slb | no |
| internal | If true, SLB will be an internal SLB | boolean | false | no |
| internet_charge_type | The charge type of load balancer instance internet network | string | PayByTraffic | no |
| bandwidth | The load balancer instance bandwidth | int | 10 | no |
| spec | The specification of the SLB instance | string | - | no |

## Outputs

| Name | Description |
|------|-------------|
| slb_id | The ID of the SLB |
| slb_name | The name of the SLB |
| slb_in_address | The ip address of the SLB |