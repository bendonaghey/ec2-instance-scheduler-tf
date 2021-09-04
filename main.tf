# module "ec2_instance" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   version = "~> 3.0"

#   name = "single-instance"

#   ami                    = "ami-087c17d1fe0178315"
#   instance_type          = "t2.micro"
#   key_name               = "ecs-course"
#   monitoring             = true
#   vpc_security_group_ids = ["sg-bf638ca2"]
#   subnet_id              = "subnet-244b412a"

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }

module "stop_ec2_instance" {
  source                         = "diodonfrost/lambda-scheduler-stop-start/aws"
  name                           = "ec2_stop"
  cloudwatch_schedule_expression = "cron(0/2 1-22 * * ? *)"
  schedule_action                = "stop"
  autoscaling_schedule           = "false"
  ec2_schedule                   = "true"
  rds_schedule                   = "false"
  cloudwatch_alarm_schedule      = "false"
  scheduler_tag                  = {
    key   = "tostop"
    value = "true"
  }
}

module "start_ec2_instance" {
  source                         = "diodonfrost/lambda-scheduler-stop-start/aws"
  name                           = "ec2_start"
  cloudwatch_schedule_expression = "cron(0/7 1-22 * * ? *)"
  schedule_action                = "start"
  autoscaling_schedule           = "false"
  ec2_schedule                   = "true"
  rds_schedule                   = "false"
  cloudwatch_alarm_schedule      = "false"
  scheduler_tag                  = {
    key   = "tostop"
    value = "true"
  }
}