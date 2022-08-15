module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = "devops-vpc-${var.env}"
  cidr = "172.18.0.0/16"

  azs              = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  public_subnets   = ["172.18.200.0/24", "172.18.201.0/24", "172.18.202.0/24"]
  private_subnets  = ["172.18.101.0/24", "172.18.102.0/24", "172.18.103.0/24"]  

  tags = {
    Terraform = "true"
    Environment = "${var.env}"
  }
}