# khai báo provider, S3
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
  region = "ap-southeast-1" # Singapore region
}

terraform {
  backend "s3" {
    bucket         = "devops-terraform-state-102"
    key            = "Teraform/terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "devops-terraform-state"
  }
}