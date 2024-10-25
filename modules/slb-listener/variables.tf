# Load Balancer Instance variables
variable "slb_load_balancer_id" {
  description = "The load balancer ID used to add one or more listeners."
  type        = string
  default     = null
}

variable "slb_server_group_id" {
  description = "The load balancer ID used to add one or more listeners."
  type        = string
  default     = null
}

# Listener common variables
variable "listeners" {
  description = "List of slb listeners. Each item can set all or part fields of alicloud_slb_listener resource."
  type = object({
    frontend_port = number
    protocol      = string
    backend_port  = optional(number, null)
    bandwidth     = optional(number, "-1")
    scheduler     = optional(string, "wrr")
  })
  default = {
    frontend_port = null
    protocol      = null
  }
}

variable "health_check_config" {
  description = "The slb listener health check settings to use on listeners. It's supports fields 'healthy_threshold','unhealthy_threshold','health_check_timeout', 'health_check', 'health_check_type', 'health_check_connect_port', 'health_check_domain', 'health_check_uri', 'health_check_http_code', 'health_check_method' and 'health_check_interval'"
  type = object({
    health_check              = optional(string, "on")
    healthy_threshold         = optional(number, 2)
    unhealthy_threshold       = optional(number, 3)
    health_check_timeout      = optional(number, 5)
    health_check_interval     = optional(number, 2)
    health_check_connect_port = optional(number, null)
    health_check_domain       = optional(string, null)
    health_check_uri          = optional(string, "/")
    health_check_http_code    = optional(string, "http_2xx")
    health_check_type         = optional(string, "tcp")
    health_check_method       = optional(string, null)
  })
  default = {
  }
}

variable "advanced_setting" {
  description = "The slb listener advanced settings to use on listeners. It's supports fields 'sticky_session', 'sticky_session_type', 'cookie', 'cookie_timeout', 'gzip', 'persistence_timeout', 'acl_status', 'acl_type', 'acl_id', 'idle_timeout' and 'request_timeout'."
  type = object({
    sticky_session      = optional(string, "off")
    sticky_session_type = optional(string, "server")
    cookie              = optional(string, null)
    cookie_timeout      = optional(number, 86400)
    gzip                = optional(string, "false")
    persistence_timeout = optional(number, null)
    established_timeout = optional(number, null)
    acl_status          = optional(string, "off")
    acl_type            = optional(string, null)
    acl_id              = optional(string, null)
    idle_timeout        = optional(number, 15)
    request_timeout     = optional(number, 60)
  })
  default = {
  }
}

variable "x_forwarded_for_config" {
  description = "Additional HTTP Header field 'X-Forwarded-For' to use on listeners. It's supports fields 'retrive_slb_ip', 'retrive_slb_id' and 'retrive_slb_proto'"
  type = object({
    retrive_slb_ip    = optional(bool, false)
    retrive_slb_id    = optional(bool, false)
    retrive_slb_proto = optional(bool, false)
  })
  default = {
  }
}

variable "ssl_certificates_config" {
  description = "SLB Server certificate settings to use on listeners. It's supports fields 'tls_cipher_policy', 'server_certificate_id' and 'enable_http2'"
  type = object({
    server_certificate_id = optional(string, null)
    tls_cipher_policy     = optional(string, null)
    enable_http2          = optional(string, "on")
  })
  default = {
  }
}
