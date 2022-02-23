# Load Balancer Instance variables
variable "name" {
  description = "The name of a new load balancer."
  type        = string
  default     = "tf-testacc-slb-name"
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

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default = {
    Name = "SLB"
  }
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

variable "virtual_server_group_name" {
  description = "The name virtual server group. If not set, the 'name' and adding suffix '-virtual' will return."
  type        = string
  default     = "tf-testacc-server-group-name"
}