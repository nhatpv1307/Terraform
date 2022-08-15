# tạo ssh keypair cho ec2 instance, https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair

#resource "aws_key_pair" "devops" {
# key_name = "devops-ssh"
  # replace the below with your public key
#  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC45C8ZG/u2+ak8oL7ana1p59YGB1WTmEHRAty5bdOxWOjkXAH2Pyn+oJZ3LS7gDJiFpWO3zkCOdKWnNWtxgKlCOnWqh5dH+YlzLxuI3x4KhR8VDhZub0EwfhmSv93vTtFyIp5F2bRLXInPq+D4Pipwufq9fUyxHYdXXdkg31/50Bkizn+ixxAU/mBrCzlA3VfhXhT0VNuCcSZvIkXdM0a1zKQrHbmNNHzLCm0aeNpg+eh/GqUu/U/fEnBTn1Bikuf6ASXLWZrXPKWXVM4R6cBcusjm8Xg1VSRLo8+/otYvqQrerbdQJssHUGwQfwFsWyBDXdxC8RZHO2jBkkIphOo9 me@longlx8.com"
#}

# tạo ec2 instance

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "web-instance-${var.env}"

  ami                    = "ami-0eaf04122a1ae7b3b" # https://cloud-images.ubuntu.com/locator/ec2/
  instance_type          = "t2.micro"
  key_name               = "key-connect-ssh"
  vpc_security_group_ids = [module.ec2_security_group.security_group_id]
  subnet_id              = element(module.vpc.public_subnets, 0)

  tags = {
    Terraform   = "true"
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
  ingress_rules       = ["all-icmp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}