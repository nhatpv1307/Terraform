module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = "devops-vpc-${var.env}"
  cidr = "172.16.0.0/16"

  azs              = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  public_subnets   = ["172.16.200.0/24", "172.16.201.0/24", "172.16.202.0/24"]
  private_subnets  = ["172.16.101.0/24", "172.16.102.0/24", "172.16.103.0/24"]  

  tags = {
    Terraform = "true"
    Environment = "${var.env}"
  }
}