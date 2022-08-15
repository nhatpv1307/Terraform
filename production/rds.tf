module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.0.2"

  identifier          = "db-${var.env}"
  engine              = "mysql"
  engine_version      = "5.7.25"
  instance_class      = "db.t3.small"
  allocated_storage   = 5
  skip_final_snapshot = true

  db_name  = "db${var.env}"
  username = "devops${var.env}"
  port     = "3306"

  # DB security group
  vpc_security_group_ids = [module.ec2_security_group.security_group_id]

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = module.vpc.private_subnets

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"
}