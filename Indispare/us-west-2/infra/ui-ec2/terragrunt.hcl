include {
  path = find_in_parent_folders()
}


terraform {
  # source = "tfr:///terraform-aws-modules/ec2-instance/aws?version=4.1.2"
  source = "../../../../modules/ec2"

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

# for_each = ["one", "two"]
# for_each = toset(["one", "two", "three"])


inputs = {

  name = "ui"
  ins_no = ["1","2"]

  ami                    = "ami-0ddf424f81ddb0720"
  instance_type          = "t2.micro"
  key_name               = "SRE"
  vpc_security_group_ids = [dependency.sg.outputs.security_group_id]
  subnet_id              = dependency.vpc.outputs.public_subnets[0]
  associate_public_ip_address = true

  tags = {
    Owner       = "SRE"
    Contact     = "SRE"
    Project     = "Indispare"
    Environment = "Development"
  }

}