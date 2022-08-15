# https://registry.terraform.io/modules/terraform-aws-modules/alb/aws/7.0.0

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "7.0.0"

  name               = "web-alb-${var.env}"
  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [module.ec2_security_group.security_group_id]

  ## Update and un-comment the below part after creating web ec2 instances

     target_groups = [
       {
         name_prefix      = "web-"
         backend_protocol = "HTTP"
         backend_port     = 80
         target_type      = "instance"
         targets = {
           web-za-01 = {
             target_id = "${local.ec2_id}"
            # "i-0e993d9fee37a0a23" # Replace with the instance id of web-za-01
             port      = 80
           }
                  }
       }
     ]

     http_tcp_listeners = [
       {
         port               = 80
         protocol           = "HTTP"
         target_group_index = 0
       }
     ]
}