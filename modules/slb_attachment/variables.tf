variable "slb" {
  description = "The ID of the SLB"
}

variable "instances" {
  description = "List of instances ID to place in the SLB pool"
  type        = list(string)
}

