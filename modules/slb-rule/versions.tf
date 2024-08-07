terraform {
  required_version = ">= 0.13"
  required_providers {
    alicloud = {
      source  = "hashicorp/alicloud"
      version = ">= 1.123.1"
    }
  }
}