# in ra output của s3 module
output "s3_bucket_name" {
  value = module.s3_bucket.name
}

output "vpc_name" {
  value = module.vpc.name
}

output "public_subnets" {
  value = module.vpc.public_subnets_cidr_blocks
}

output "private_subnets" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "ec2_instance_id" {
  value = module.ec2_instance.id
}

output "ec2_instance_ip_public" {
  value = module.ec2_instance.public_ip
}