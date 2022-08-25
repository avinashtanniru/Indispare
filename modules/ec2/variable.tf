
variable "ins_no" {
  description = "The name to use for all the cluster resources"
  type        = list
}

variable "name" {
  description = "The name to use for all the cluster resources"
  type        = string
}

variable "ami" {
  description = "The name to use for all the cluster resources"
  type        = string
}

variable "instance_type" {
  description = "The name to use for all the cluster resources"
  type        = string
}

variable "key_name" {
  description = "The name to use for all the cluster resources"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "The name to use for all the cluster resources"
  type        = list
}

variable "subnet_id" {
  description = "The name to use for all the cluster resources"
  type        = string
}

variable "tags" {
  description = "The name to use for all the cluster resources"
  type        = map
}
