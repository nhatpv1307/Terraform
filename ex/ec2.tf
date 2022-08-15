resource "aws_instance" "web-terraform" {

  ami           = "ami-0d058fe428540cd89"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_vpc.id

  key_name               = aws_key_pair.devops.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "web-devops-01"
  }
}

# tạo ssh keypair

resource "aws_key_pair" "devops" {
  key_name   = "key-connect-ssh"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC670DLXjVdsvulJ1Duw4xrRolHHCEYyhChDB6WprJNWr2iBa1Ryg3jMUmBy5qU5M8/8kPp8Vn6MlHA5hlH5Gm/MwJPZs9zdObtGadxrvLUcfZo6l74zlSDgQlrMJYkywxMH2EtdcSbbw3X+QKCHGwz6/KPey8QMsGunvv6cDdZN+1JtJPgD6U58qVsEF0nXcOvBg8F8QzreCcN7wI4IrSFco+6n+1PUZv2rzcbZ1L5AnLLs2MfJb++7icH3XB+l+rDP5mihKBIe2ogX04wlFnolYDh5O45RvrMb23As80U2JhD5OEW6/uJtLaPHYwZTXhzM0F/ocvzhrCR6keptQ0Sk6/HroDF4ry8fUX9mifsMA1XOqj9eY4K4WI/L9I1Xv8qw2B4O5WzqYFiI85c5qRzMJ0NZCLFz//i8K6XDGC3z7KcQC1DTu8qj6VESSJY4GQ26ZJCELalTaqCz1DFoXEpAaohAyx6dx9LyCqlpi2yxrdWOLagVyt37Q9nOtv++6c= nhatpv@nhatpv-Vostro-3670"
}

# tạo security group allow ssh

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.devpos.id

  ingress {
    description = "SSH from specify IPs"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["35.247.128.96/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# in ra public ip của ec2 instance
output "ec2_instance_public_ips" {
  value = ["${aws_instance.web-terraform.*.public_ip}"]
}