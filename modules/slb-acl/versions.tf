
terraform {
  required_version = ">= 0.12"
  required_providers {
    alicloud = {
      source  = "hashicorp/alicloud"
      version = ">= 1.162.0"
    }
  }
}
