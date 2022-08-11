
# Tao VPC 
resource "aws_vpc" "devpos" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = var.name_vpc
  }
}

#Tao Public subnet
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.devpos.id
  cidr_block              = "172.16.1.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.name_public
  }
}

#Tao internal network GW
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.devpos.id
  tags = {
    Name = var.name_igw
  }
}


# tạo public routing table cho public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.devpos.id
  tags = {
    Name = var.name_routing
  }
}
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}


# gán public subnet vào public routing table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}



variable "name_vpc" {
  default = "vpc-devops"

}

variable "name_public" {
  default = join(var.name_pc,"-public") 

}

variable "name_igw" {
  default = join(var.name_public,"-igw")

}

variable "name_routing" {
  default = join(var.name_igw,"-roungting")

}