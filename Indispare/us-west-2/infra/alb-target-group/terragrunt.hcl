include {
  path = find_in_parent_folders()
}

terraform {
  source = "tfr://registry.terraform.io/terraform-aws-modules/alb/aws?version=7.0.0"

  extra_arguments "init_args" {
    commands = [
      "init"
    ]
    arguments = [
    ]
  }
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "sg" {
  config_path = "../security-group"
}

dependency "api" {
  config_path = "../api-ec2"
}

dependency "ui" {
  config_path = "../ui-ec2"
}

inputs = {

  name = "terr-alb-api"

  load_balancer_type = "application"

  vpc_id             = dependency.vpc.outputs.vpc_id
  subnets            = dependency.vpc.outputs.public_subnets

  security_groups    = [dependency.sg.outputs.security_group_id]

  # access_logs = {
  #   bucket = "indispare-logs"
  # }

  target_groups = [
    {
      name_prefix      = "api-"
      backend_protocol = "HTTP"
      backend_port     = 8080
      target_type      = "instance"
      targets = {
        api-1 = {
          target_id = dependency.api.outputs.ec2-id[0]
          port = 80
        },
        api-2 = {
          target_id = dependency.api.outputs.ec2-id[1]
          port = 80
        }
      }
    },
    {
      name_prefix      = "ui-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        ui-1 = {
          target_id = dependency.ui.outputs.ec2-id[0]
          port = 80
        },
        ui-2 = {
          target_id = dependency.ui.outputs.ec2-id[1]
          port = 80
        }
      }
    }
  ]

  # https_listeners = [
  #   {
  #     port               = 443
  #     protocol           = "HTTPS"
  #     certificate_arn    = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
  #     target_group_index = 0
  #   }
  # ]

  http_tcp_listeners = [
    {
      port               = 8080
      protocol           = "HTTP"
      target_group_index = 0
    },
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 1
    }
  ]

  tags = {
    Name        = "Terragrunt-ALB"
    Owner       = "SRE"
    Contact     = "SRE"
    Project     = "Indispare"
    Environment = "Development"
  }
}