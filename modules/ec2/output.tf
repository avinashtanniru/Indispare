output "ec2-id" {
  value = [module.ec2_instance.1.id,module.ec2_instance.2.id]
}

output "ec2-instance_state" {
  value = [module.ec2_instance.1.instance_state, module.ec2_instance.2.instance_state]
}

output "ec2-private_ip" {
  value = [module.ec2_instance.1.private_ip, module.ec2_instance.2.private_ip]
}

output "ec2-public_ip" {
  value = [module.ec2_instance.1.public_ip, module.ec2_instance.2.public_ip]
}

