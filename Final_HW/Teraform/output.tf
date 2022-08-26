# in ra output của s3 module

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
  value = module.ec2_instance[*].public_ip
}

output "alb_dns_name" {
  value = module.alb.lb_dns_name
}

output "db_enpoint" {
  value = module.db.db_instance_endpoint
}

output "db_name" {
  value = module.db.db_instance_name
}