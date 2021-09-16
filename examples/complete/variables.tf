
# Load Balancer Instance variables
variable "name" {
  description = "The name of a new load balancer."
  type        = string
  default     = "tf-module-slb-test-001"
}

variable "bandwidth" {
  description = "The load balancer instance bandwidth."
  type        = number
  default     = 10
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {
    tag_a = 1
    tag_b = 2
    tag_c = 3
  }
}

variable "virtual_server_group_name" {
  description = " Name of the virtual server group."
  type        = string
  default     = "tf-server-group-001"
}

variable "weight" {
  description = "Weight of the backend server. Valid value range: [0-100]."
  type        = string
  default     = 100
}

variable "port" {
  description = "The port used by the backend server. Valid value range: [1-65535]."
  type        = string
  default     = 100
}

variable "server_type" {
  description = "The server type of the backend server. Valid value Master, Slave."
  type        = string
  default     = "Slave"
}

variable "type" {
  description = "The port used by the backend server. Valid value range: [1-65535]."
  type        = string
  default     = "ecs"
}
