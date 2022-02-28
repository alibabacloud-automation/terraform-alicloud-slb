variable "region" {
  description = "(Deprecated from version 1.7.0) The region used to launch this module resources."
  type        = string
  default     = ""
}

variable "profile" {
  description = "(Deprecated from version 1.7.0) The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  type        = string
  default     = ""
}
variable "shared_credentials_file" {
  description = "(Deprecated from version 1.7.0) This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  type        = string
  default     = ""
}

variable "skip_region_validation" {
  description = "(Deprecated from version 1.7.0) Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  type        = bool
  default     = false
}

variable "internal" {
  description = "(Deprecated) It has been deprecated from 1.6.0 and 'address_type' instead. If true, SLB instance will be an internal SLB."
  type        = bool
  default     = false
}

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