# khai báo provider, xác thực
# https://registry.terraform.io/providers/hashicorp/aws/latest

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.20.1"
    }
  }
}

provider "aws" {
  // access_key = "***"
  // secret_key = "***"
  region = "ap-southeast-1" # Singapore region
}