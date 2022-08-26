module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = "final-vpc-${var.env}"
  cidr = "172.16.0.0/16"

  azs              = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  public_subnets   = ["172.16.200.0/24", "172.16.201.0/24", "172.16.202.0/24"]
  private_subnets  = ["172.16.101.0/24", "172.16.102.0/24", "172.16.103.0/24"]  

  tags = {
    Terraform = "true"
    Environment = "${var.env}"
  }
}

# https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/4.9.0

module "ec2_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "web-security-group-${var.env}"
  description = "Security group for Web ec2 instances"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}

module "security_group_rds" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "rds-${var.env}"
  description = "Security group for RDS db instances"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "172.16.0.0/16"
    }
  ]
}