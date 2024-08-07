# Load Balancer Instance variables
variable "create" {
  description = "Whether to create load balancer instance. If setting 'use_existing_slb = true' and 'existing_slb_id', it will be ignored."
  type        = bool
  default     = true
}

variable "use_existing_slb" {
  description = "Whether to use an existing load balancer instance. If true, 'existing_slb_id' should not be empty. Also, you can create a new one by setting 'create = true'."
  type        = bool
  default     = false
}

variable "existing_slb_id" {
  description = "An existing load balancer instance id."
  type        = string
  default     = ""
}

variable "name" {
  description = "The name of a new load balancer."
  type        = string
  default     = ""
}

variable "internet_charge_type" {
  description = "The charge type of load balancer instance internet network."
  type        = string
  default     = "PayByTraffic"
}

variable "address_type" {
  description = "The type of address. Choices are 'intranet' and 'internet'. Default to 'internet'."
  type        = string
  default     = "internet"
}

variable "vswitch_id" {
  description = "The vswitch id used to launch load balancer."
  type        = string
  default     = ""
}

variable "spec" {
  description = "The specification of the SLB instance."
  type        = string
  default     = "slb.s1.small"
}

variable "bandwidth" {
  description = "The load balancer instance bandwidth."
  type        = number
  default     = 10
}

variable "master_zone_id" {
  description = "The primary zone ID of the SLB instance. If not specified, the system will be randomly assigned."
  type        = string
  default     = ""
}

variable "slave_zone_id" {
  description = "The standby zone ID of the SLB instance. If not specified, the system will be randomly assigned."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

# Load Balancer Instance attachment
variable "servers_of_default_server_group" {
  description = "A list of attached ECS instances, it's supports fields 'server_ids', 'weight'(default to 100), and 'type'(default to 'ecs')."
  type        = list(map(string))
  default     = []
}

variable "master_slave_server_group_name" {
  description = "The name master slave server group. If not set, the 'name' and adding suffix '-master-slave' will return."
  type        = string
  default     = ""
}

variable "servers_of_master_slave_server_group" {
  description = "A list of servers attaching to master-slave server group, it's supports fields 'server_ids', 'weight'(default to 100), 'port', 'server_type' and 'type'(default to 'ecs')."
  type        = list(map(string))
  default     = []
}

variable "virtual_server_group_name" {
  description = "The name virtual server group. If not set, the 'name' and adding suffix '-virtual' will return."
  type        = string
  default     = ""
}

variable "servers_of_virtual_server_group" {
  description = "A list of servers attaching to virtual server group, it's supports fields 'server_ids', 'weight'(default to 100), 'port' and 'type'(default to 'ecs')."
  type        = list(map(string))
  default     = []
}


# access control list
variable "create_slb_acl" {
  description = "Whether to create slb acl."
  type        = bool
  default     = false
}

variable "acl_name" {
  description = "the Name of the access control list."
  type        = string
  default     = ""
}

variable "acl_ip_version" {
  description = "The IP Version of access control list is the type of its entry (IP addresses or CIDR blocks). It values ipv4/ipv6. Our plugin provides a default ip_version: ipv4."
  type        = string
  default     = "ipv4"
}

variable "acl_entry_list" {
  description = " A list of entry (IP addresses or CIDR blocks) to be added. At most 50 etnry can be supported in one resource. It contains two sub-fields as: entry(IP addresses or CIDR blocks), comment(the comment of the entry)"
  type = list(object({
    entry   = string
    comment = optional(string, null)
  }))
  default = []
}

variable "acl_tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}


# slb listener
variable "create_slb_listener" {
  description = "Whether to create slb listener."
  type        = bool
  default     = false
}

variable "listener_config" {
  description = "A list of listener config."
  type = list(object({
    server_group_id         = optional(string, "")
    listeners               = map(string)
    health_check_config     = optional(map(string), {})
    advanced_setting        = optional(map(string), {})
    x_forwarded_for_config  = optional(map(string), {})
    ssl_certificates_config = optional(map(string), {})
    })
  )
  default = []
}


# rule
variable "create_slb_rule" {
  description = "Whether to create slb listener."
  type        = bool
  default     = false
}

variable "rule_config" {
  description = "A list of rule config."
  type = list(object({
    load_balancer_id          = optional(string, null)
    frontend_port             = optional(string, null)
    server_group_id           = optional(string, null)
    name                      = optional(string, null)
    domain                    = optional(string, null)
    url                       = optional(string, null)
    cookie                    = optional(string, null)
    cookie_timeout            = optional(string, null)
    health_check_http_code    = optional(string, null)
    health_check_interval     = optional(string, null)
    health_check_uri          = optional(string, null)
    health_check_connect_port = optional(string, null)
    health_check_timeout      = optional(string, null)
    healthy_threshold         = optional(string, null)
    unhealthy_threshold       = optional(string, null)
    sticky_session            = optional(string, null)
    sticky_session_type       = optional(string, null)
    listener_sync             = optional(string, null)
    scheduler                 = optional(string, null)
    health_check_domain       = optional(string, null)
    health_check              = optional(string, null)
  }))
  default = []
}
