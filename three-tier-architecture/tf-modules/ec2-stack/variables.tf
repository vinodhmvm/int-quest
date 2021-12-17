# RDS Related variables passed via modules in main.tf
variable "amis" {}
variable "instance_type" {}
variable "vpc_id" {}
variable "public_subnet1" {}
variable "out_bastion_ssh" {}
variable "private_subnet3" {}
variable "private_subnet4" {}
variable "max_asgp" {}
variable "min_asgp" {}
variable "out_alb_sg" {}
variable "out_ec2_sg" {}
variable "stackname" {}