resource "aws_vpc" "devpos" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = var.name_vpc
  }
}

variable "name_vpc" {
  default = "vpc-devops3"

}