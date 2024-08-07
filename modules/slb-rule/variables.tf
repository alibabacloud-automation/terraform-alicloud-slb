variable "load_balancer_id" {
  description = "The ID of SLB load balancer."
  type        = string
  default     = null
}

variable "server_group_id" {
  description = "The ID of SLB server group."
  type        = string
  default     = null
}

variable "frontend_port" {
  description = "The frontend port of SLB listener."
  type        = string
  default     = null
}

variable "name" {
  description = "The name of slb rule."
  type        = string
  default     = null
}


variable "health_check_connect_port" {
  description = "Port used for health check. Valid value range: [1-65535]. Default to `None` means the backend server port is used."
  type        = string
  default     = "20"
}

variable "domain" {
  description = "Domain name of the forwarding rule. It can contain letters a-z, numbers 0-9, hyphens (-), and periods (.), and wildcard characters."
  type        = string
  default     = "*.aliyun.com"
}

variable "url" {
  description = "Domain of the forwarding rule. It must be 2-80 characters in length. Only letters a-z, numbers 0-9, and characters '-' '/' '?' '%' '#' and '&' are allowed. URLs must be started with the character '/', but cannot be '/' alone."
  type        = string
  default     = ""
}

variable "cookie" {
  description = "The cookie configured on the server. It is mandatory when `sticky_session` is `on` and `sticky_session_type` is `server`. Otherwise, it will be ignored. Valid value：String in line with RFC 2965, with length being 1- 200. It only contains characters such as ASCII codes, English letters and digits instead of the comma, semicolon or spacing, and it cannot start with $."
  type        = string
  default     = "cookie_test"
}

variable "cookie_timeout" {
  description = "Cookie timeout. It is mandatory when sticky_session is `on` and sticky_session_type is `insert`. Otherwise, it will be ignored. Valid value range: [1-86400] in seconds."
  type        = number
  default     = 100
}

variable "health_check_http_code" {
  description = "Regular health check HTTP status code. Multiple codes are segmented by “,”. It is required when health_check is on. Default to `http_2xx`. Valid values are: `http_2xx`, `http_3xx`, `http_4xx` and `http_5xx`."
  type        = string
  default     = "http_2xx"
}

variable "health_check_interval" {
  description = "Time interval of health checks. It is required when `health_check` is on. Valid value range: [1-50] in seconds. Default to 2."
  type        = number
  default     = 2
}

variable "health_check_uri" {
  description = "URI used for health check. When it used to launch TCP listener, health_check_type must be `http`. Its length is limited to 1-80 and it must start with /. Only characters such as letters, digits, ‘-’, ‘/’, ‘.’, ‘%’, ‘?’, #’ and ‘&’ are allowed."
  type        = string
  default     = "/test"
}

variable "health_check_timeout" {
  description = "Maximum timeout of each health check response. It is required when `health_check` is on. Valid value range: [1-300] in seconds. Default to 5. Note: If `health_check_timeout` < `health_check_interval`, its will be replaced by `health_check_interval`."
  type        = number
  default     = 30
}

variable "healthy_threshold" {
  description = "Threshold determining the result of the health check is success. It is required when `health_check` is on. Valid value range: [1-10] in seconds. Default to 3."
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "Threshold determining the result of the health check is fail. It is required when `health_check` is on. Valid value range: [1-10] in seconds. Default to 3."
  type        = number
  default     = 3
}

variable "sticky_session" {
  description = "Whether to enable session persistence, Valid values are `on` and `off`. Default to `off`. This parameter is required and takes effect only when ListenerSync is set to `off`."
  type        = string
  default     = "on"
}

variable "sticky_session_type" {
  description = "Mode for handling the cookie. If sticky_session is `on`, it is mandatory. Otherwise, it will be ignored. Valid values are insert and server. insert means it is inserted from Server Load Balancer; server means the Server Load Balancer learns from the backend server."
  type        = string
  default     = "server"
}

variable "listener_sync" {
  description = "Indicates whether a forwarding rule inherits the settings of a health check , session persistence, and scheduling algorithm from a listener. Default to on."
  type        = string
  default     = "off"
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
