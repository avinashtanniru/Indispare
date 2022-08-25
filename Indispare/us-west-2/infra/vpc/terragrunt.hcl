include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git//?ref=v3.11.0"

  extra_arguments "init_args" {
    commands = [
      "init"
    ]
    arguments = [
    ]
  }
}

inputs = {
  name = "Main"
  cidr = "10.2.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.2.10.0/23", "10.2.12.0/23"]
  public_subnets  = ["10.2.0.0/23", "10.2.2.0/23"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "Terragrunt-VPC"
    Owner       = "SRE"
    Contact     = "SRE"
    Project     = "Indispare"
    Environment = "Development"
  }
}