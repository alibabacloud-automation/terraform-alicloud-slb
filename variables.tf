variable "region" {
  description = "The region used to launch this module resources."
  type        = string
  default     = ""
}

variable "profile" {
  description = "The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  type        = string
  default     = ""
}
variable "shared_credentials_file" {
  description = "This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  type        = string
  default     = ""
}

variable "skip_region_validation" {
  description = "Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  type        = bool
  default     = false
}

# VSwitch variables
variable "vswitch_id" {
  description = "The vswitch id used to launch load balancer."
  type        = string
  default     = ""
}

# Load Balancer Instance variables

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

variable "create" {
  description = "Whether to create load balancer instance. If setting 'use_existing_slb = true' and 'existing_slb_id', it will be ignored."
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of a new load balancer."
  type        = string
  default     = "tf-module-slb"
}

variable "internal" {
  description = "If true, SLB instance will be an internal SLB."
  type        = bool
  default     = false
}

variable "internet_charge_type" {
  description = "The charge type of load balancer instance internet network."
  type        = string
  default     = "PayByTraffic"
}

variable "bandwidth" {
  description = "The load balancer instance bandwidth."
  type        = number
  default     = 10
}

variable "spec" {
  description = "The specification of the SLB instance."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
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

# Load Balancer Instance attachment

variable "servers_of_default_server_group" {
  description = "A list of attached ECS instances, it's supports fields 'server_ids', 'weight', and 'type'."
  type        = list(map(string))
  default     = []
}

variable "servers_of_master_slave_server_group" {
  description = "A list of master slave servers, it's supports fields 'server_ids', 'weight', 'port', 'server_type' and 'type'."
  type        = list(map(string))
  default     = []
}

variable "servers_of_virtual_server_group" {
  description = "A list of virtual servers, it's supports fields 'server_ids', 'weight', 'port' and 'type'."
  type        = list(map(string))
  default     = []
}
