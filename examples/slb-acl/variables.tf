variable "acl_name" {
  default     = "tf-example-module-slb-acl"
  description = "The name of the access control list."
  type        = string
}

variable "acl_ip_version" {
  description = "The IP Version of access control list is the type of its entry (IP addresses or CIDR blocks). It values ipv4/ipv6. Our plugin provides a default ip_version: ipv4."
  type        = string
  default     = "ipv4"
}

variable "acl_entry_list" {
  description = "The list of acl entry."
  type = list(object({
    entry   = string
    comment = optional(string, null)
  }))
  default = [
    {
      entry   = "10.10.10.0/24"
      comment = "first"
    },
    {
      entry   = "168.10.10.0/24"
      comment = "second"
    },
    {
      entry   = "172.10.10.0/24"
      comment = "third"
    },
  ]
}

