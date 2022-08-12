
# Tao VPC 
resource "aws_vpc" "devpos" {
  cidr_block = "172.16.0.0/16"

  tags = {
    #Name = var.name_vpc
    name = "${local.name_vpc}"

  }
}

#Tao Public subnet
resource "aws_subnet" "public_vpc" {
  vpc_id                  = aws_vpc.devpos.id
  cidr_block              = "172.16.100.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    #Name = var.name_public_subnet
    Name = "${local.name_vpc}-${local.name_public_subnet}"

  }
}

#Tao internal network GW
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.devpos.id
  tags = {
    #Name = var.name_igw
    Name = "${local.name_vpc}-${local.name_public_subnet}-${local.name_igw}"

  }
}


# tạo public routing table cho public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.devpos.id
  tags = {
    # Name = var.name_routing
    Name = "${local.name_vpc}-${local.name_public_subnet}-${local.name_igw}-${local.name_routing}"
  }
}
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}


# gán public subnet vào public routing table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_vpc.id
  route_table_id = aws_route_table.public.id
}



variable "name_vpc" {
  default = "vpc-devops"

}

variable "name_public_subnet" {
  default = "vpc-devops-subnet"

}

variable "name_igw" {
  default = "vpc-devops-subnet-igw"

}

variable "name_routing" {
  default = "vpc-devops-subnet-igw-routing"

}