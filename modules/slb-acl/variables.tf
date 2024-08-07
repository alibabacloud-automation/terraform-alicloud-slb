variable "name" {
  description = "the Name of the access control list."
  type        = string
  default     = ""
}

variable "ip_version" {
  description = "The IP Version of access control list is the type of its entry (IP addresses or CIDR blocks). It values ipv4/ipv6. Our plugin provides a default ip_version: ipv4."
  type        = string
  default     = "ipv4"
}

variable "entry_list" {
  description = " A list of entry (IP addresses or CIDR blocks) to be added. At most 50 etnry can be supported in one resource. It contains two sub-fields as: entry(IP addresses or CIDR blocks), comment(the comment of the entry)"
  type = list(object({
    entry   = string
    comment = optional(string, null)
  }))
  default = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
