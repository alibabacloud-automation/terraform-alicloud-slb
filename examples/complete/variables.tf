
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

# Load Balancer Instance attachment

variable "servers_of_default_server_group" {
  description = "A list of attached ECS instances, it's supports fields 'server_ids', 'weight'(default to 100), and 'type'(default to 'ecs')."
  type        = list(map(string))
  default     = []
}

variable "servers_of_master_slave_server_group" {
  description = "A list of servers attaching to master-slave server group, it's supports fields 'server_ids', 'weight'(default to 100), 'port', 'server_type' and 'type'(default to 'ecs')."
  type        = list(map(string))
  default     = []
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


variable "servers_of_virtual_server_group" {
  description = "A list of servers attaching to virtual server group, it's supports fields 'server_ids', 'weight'(default to 100), 'port' and 'type'(default to 'ecs')."
  type        = list(map(string))
  default     = []
}
