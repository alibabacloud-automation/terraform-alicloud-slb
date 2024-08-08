##############################################################
#variables for alicloud_instance_types
##############################################################
variable "name" {
  description = "The name of a new load balancer."
  type        = string
  default     = "slb-rule-basic-config"
}

variable "cpu_core_count" {
  description = "Number of CPU cores."
  type        = number
  default     = 1
}

variable "memory_size" {
  description = "Size of memory, measured in GB."
  type        = number
  default     = 2
}
##############################################################
#variables for alicloud_images
##############################################################
variable "images_name_regex" {
  description = "A regex string to filter resulting images by name."
  type        = string
  default     = "^ubuntu_18.*64"
}

variable "images_most_recent" {
  description = "If more than one result are returned, select the most recent one."
  type        = bool
  default     = true
}

variable "images_owners" {
  description = "Filter results by a specific image owner. Valid items are `system`, `self`, `others`, `marketplace`."
  type        = string
  default     = "system"
}

##############################################################
#variables for alicloud_slb_load_balancer
##############################################################
variable "vswitch_id" {
  description = "VSwitch variables, if vswitch_id is empty, then the net_type = classic."
  type        = string
  default     = ""
}

variable "spec" {
  description = "The specification of the SLB instance."
  type        = string
  default     = "slb.s1.small"
}

##############################################################
#variables for alicloud_slb_listener
##############################################################

variable "bandwidth" {
  description = "Bandwidth peak of Listener."
  type        = number
  default     = 5
}

variable "health_check_connect_port" {
  description = "Port used for health check. Valid value range: [1-65535]. Default to `None` means the backend server port is used."
  type        = string
  default     = "20"
}
##############################################################
#variables for alicloud_slb_rule
##############################################################

variable "cookie" {
  description = "The cookie configured on the server. It is mandatory when `sticky_session` is `on` and `sticky_session_type` is `server`. Otherwise, it will be ignored. Valid value：String in line with RFC 2965, with length being 1- 200. It only contains characters such as ASCII codes, English letters and digits instead of the comma, semicolon or spacing, and it cannot start with $."
  type        = string
  default     = "cookie_test"
}

variable "rule_health_check_connect_port" {
  description = "Port used for health check. Valid value range: [1-65535]. Default to `None` means the backend server port is used."
  type        = number
  default     = 80
}

variable "health_check_timeout" {
  description = "Maximum timeout of each health check response. It is required when `health_check` is on. Valid value range: [1-300] in seconds. Default to 5. Note: If `health_check_timeout` < `health_check_interval`, its will be replaced by `health_check_interval`."
  type        = number
  default     = 30
}

variable "unhealthy_threshold" {
  description = "Threshold determining the result of the health check is fail. It is required when `health_check` is on. Valid value range: [1-10] in seconds. Default to 3."
  type        = number
  default     = 3
}

variable "scheduler" {
  description = "Scheduling algorithm, Valid values are `wrr`, `rr` and `wlc`. Default to `wrr`. This parameter is required and takes effect only when ListenerSync is set to `off`."
  type        = string
  default     = "rr"
}

variable "health_check_domain" {
  description = "Domain name used for health check. When it used to launch TCP listener, health_check_type must be `http`. Its length is limited to 1-80 and only characters such as letters, digits, ‘-‘ and ‘.’ are allowed. When it is not set or empty, Server Load Balancer uses the private network IP address of each backend server as Domain used for health check."
  type        = string
  default     = "test"
}

variable "health_check" {
  description = "Whether to enable health check. Valid values are `on` and `off`. TCP and UDP listener's HealthCheck is always on, so it will be ignore when launching TCP or UDP listener. This parameter is required and takes effect only when ListenerSync is set to off."
  type        = string
  default     = "on"
}

variable "cookie_timeout" {
  description = "Cookie timeout. It is mandatory when sticky_session is `on` and sticky_session_type is `insert`. Otherwise, it will be ignored. Valid value range: [1-86400] in seconds."
  type        = number
  default     = 100
}