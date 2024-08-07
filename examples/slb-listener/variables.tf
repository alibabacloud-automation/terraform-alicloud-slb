#alicloud_slb_acl and alicloud_slb_server_certificate
variable "name" {
  description = "The specification of module name."
  type        = string
  default     = "tf-testacc-name"
}

#ECS
variable "system_disk_size" {
  description = "Size of the system disk, measured in GiB."
  type        = number
  default     = 50
}

# Load Balancer Instance attachment
variable "port" {
  description = "The port used by the backend server."
  type        = number
  default     = 80
}

variable "weight" {
  description = "Weight of the backend server."
  type        = number
  default     = 10
}

# Listener common variables
variable "bandwidth" {
  description = "Bandwidth peak of Listener."
  type        = number
  default     = -1
}

variable "scheduler" {
  description = "Scheduling algorithm, Valid values: wrr, rr, wlc, sch, tcp, qch."
  type        = string
  default     = "wrr"
}

# Health Check
variable "health_check" {
  description = "Whether to enable health check. Valid values areon and off."
  type        = string
  default     = "off"
}

variable "healthy_threshold" {
  description = "The number of health checks that an unhealthy backend server must consecutively pass before it can be declared healthy."
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "The number of health checks that a healthy backend server must consecutively fail before it can be declared unhealthy."
  type        = number
  default     = 3
}

variable "health_check_timeout" {
  description = "Maximum timeout of each health check response."
  type        = number
  default     = 5
}

variable "health_check_interval" {
  description = "Time interval of health checks."
  type        = number
  default     = 2
}

variable "health_check_connect_port" {
  description = "The port that is used for health checks."
  type        = number
  default     = 10
}

variable "health_check_domain" {
  description = "Domain name used for health check."
  type        = string
  default     = "ali.com"
}

variable "health_check_uri" {
  description = "URI used for health check."
  type        = string
  default     = "/cons"
}

variable "health_check_http_code" {
  description = "Regular health check HTTP status code."
  type        = string
  default     = "http_2xx"
}

variable "health_check_type" {
  description = "Type of health check."
  type        = string
  default     = "tcp"
}

variable "health_check_method" {
  description = "HealthCheckMethod used for health check."
  type        = string
  default     = "head"
}

# Advance setting
variable "sticky_session" {
  description = "Whether to enable session persistence, Valid values are on and off. Default to off."
  type        = string
  default     = "on"
}

variable "sticky_session_type" {
  description = "Mode for handling the cookie."
  type        = string
  default     = "insert"
}

variable "cookie" {
  description = "The cookie configured on the server."
  type        = string
  default     = "test"
}

variable "cookie_timeout" {
  description = "Cookie timeout."
  type        = number
  default     = 1
}

variable "gzip" {
  description = "Whether to enable 'Gzip Compression'."
  type        = bool
  default     = true
}

variable "persistence_timeout" {
  description = "Timeout of connection persistence."
  type        = number
  default     = 10
}

variable "established_timeout" {
  description = "Timeout of tcp listener established connection idle timeout."
  type        = number
  default     = 10
}

variable "acl_status" {
  description = "Whether to enable 'acl(access control list)', the acl is specified by acl_id."
  type        = string
  default     = "on"
}

variable "acl_type" {
  description = "Mode for handling the acl specified by acl_id."
  type        = string
  default     = "white"
}

variable "idle_timeout" {
  description = "Timeout of http or https listener established connection idle timeout."
  type        = number
  default     = 15
}

variable "request_timeout" {
  description = "Timeout of http or https listener request (which does not get response from backend) timeout."
  type        = number
  default     = 60
}

# x_forwarded_for setting
variable "retrive_slb_ip" {
  description = "Whether to use the XForwardedFor_SLBIP header to obtain the public IP address of the SLB instance."
  type        = bool
  default     = true
}

variable "retrive_slb_id" {
  description = "Whether to use the XForwardedFor header to obtain the ID of the SLB instance."
  type        = bool
  default     = true
}

variable "retrive_slb_proto" {
  description = "Whether to use the XForwardedFor_proto header to obtain the protocol used by the listener."
  type        = bool
  default     = true
}

# Ssl certificate setting
variable "tls_cipher_policy" {
  description = "Https listener TLS cipher policy."
  type        = string
  default     = "tls_cipher_policy_1_0"
}

variable "enable_http2" {
  description = "Whether to enable https listener support http2 or not."
  type        = string
  default     = "on"
}