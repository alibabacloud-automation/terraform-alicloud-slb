# common variables
variable "alicloud_access_key" {
  description = "The Alicloud Access Key ID to launch resources."
  default = ""
}
variable "alicloud_secret_key" {
  description = "The Alicloud Access Secret Key to launch resources."
  default = ""
}
variable "region" {
  description = "The region to launch resources."
  default = ""
}

# VSwitch variables
variable "vswitch_id" {
  description = "The vswitch id used to launch load balancer."
  default = ""
}

# Load Balancer Instance variables
variable "slb_name" {
  description = "The load balancer instance name used to launch a new load balancer."
  default = "TF_Load_Balancer_HTTP"
}
variable "is_internet" {
  description = "whether the load balancer instance's network type is internet."
  default = false
}
variable "internet_charge_type" {
  description = "The charge type of load balancer instance internet network."
  default = "paybytraffic"
}
variable "slb_bandwidth" {
  description = "The load balancer instance bandwidth."
  default = 1
}

# Load Balancer HTTP Listener variables
variable "backend_port" {
  description = "The port the service running on the ECS instances will listen on"
}
variable "front_port" {
  description = "The port the service running on the SLB instance will listen on"
  default = 80
}

variable "listener_bandwidth" {
  description = "Load balancer listener bandwidth. Its valid in -1/1-1000Mbps and -1 means there is no limit when using 'paybytraffic'"
}
variable "scheduler" {
  description = "Load balancer listener scheduler."
  default = "wrr"
}
variable "sticky_session" {
  description = "Whether keep load balancer listener session."
  default = "off"
}
variable "sticky_session_type" {
  description = "Load balancer listener sticky session type."
  default = "server"
}
variable "cookie_timeout" {
  description = "Load balancer listener cookie timeout."
  default = 86400
}
variable "cookie" {
  description = "Load balancer listener cookie."
  default = ""
}
variable "health_check" {
  description = "Whether load balancer listener do health check."
  default = "off"
}

variable "check_domain" {
  description = "Health check domain of the load balancer listener."
  default = ""
}
variable "check_uri" {
  description = "Health check uri of the load balancer listener."
  default = ""
}
variable "check_connect_port" {
  description = "Health check connection port of the load balancer listener."
  default = -520
}
variable "healthy_threshold" {
  description = "Healthy threshold of the load balancer listener is used to estimate whether the check result is success."
  default = 10
}
variable "unhealthy_threshold" {
  description = "unhealthy threshold of the load balancer listener is used to estimate whether the check result is fail."
  default = 10
}
variable "check_timeout" {
  description = "Health check timeout of the load balancer listener."
  default = 10
}
variable "check_interval" {
  description = "Health check interval of the load balancer listener."
  default = 5
}
variable "check_http_code" {
  description = "Normal health check http code of the load balancer."
  default = "http_2xx"
}

# backend servers variables
variable "server_ids" {
  description = "List of ECS instance IDs used to add backend servers for load balancer."
  type = "list"
  default = []
}