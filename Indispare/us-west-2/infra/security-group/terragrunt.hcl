include {
  path = find_in_parent_folders()
}

terraform {
  source = "tfr:///terraform-aws-modules/security-group/aws?version=4.9.0"

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


inputs = {
  
  name        = "terra-ec2"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = dependency.vpc.outputs.vpc_id

  ingress_cidr_blocks      = ["10.2.0.0/16"]
  ingress_rules            = ["all-icmp","http-80-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow SSH Ports"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allow HTTP Ports"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "Allow 8080 Ports"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_cidr_blocks      = ["0.0.0.0/0"]
  egress_rules            = ["all-tcp"]

}