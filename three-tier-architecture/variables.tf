# ASG Variables
variable "min_asg_value" {
  default = "2"
}

variable "max_asg_value" {
  default = "4"
}
#AWS Common Variables
variable "region" {
  default = "us-east-1"
}
variable "aws_profile" {
  default = "default"
}
#AWS EC2 Related Variables
variable "aws_instance_type" {
  default = "t3.micro"
}
variable "ami_id" {
  default = "ami-0ed9277fb7eb570c9"
}

#AWS VPC Related Variables
variable "aws_cidr_block" {
  default = "10.0.0.0/16"
}
variable "aws_public_subnet_1" {
  default = "10.0.1.0/24"
}
variable "aws_public_subnet_2" {
  default = "10.0.2.0/24"
}
variable "aws_private_subnet_3" {
  default = "10.0.3.0/24"
}
variable "aws_private_subnet_4" {
  default = "10.0.4.0/24"
}
variable "aws_availability_zone_A" {
  default = "us-east-1a"
}
variable "aws_availability_zone_B" {
  default = "us-east-1b"
}
variable "aws_any_ip" {
  default = "0.0.0.0/0"
}

#AWS DB Related Variables
variable "mysql_db_allocated_storage" {
  default = "30"
}
variable "mysql_db_storage_type" {
  default = "gp2"
}
variable "mysql_db_engine" {
  default = "mysql"
}
variable "mysql_db_engine_version" {
  default = "8.0.20"
}

variable "mysql_db_instance_class" {
  default = "db.t3.micro"
}
variable "mysql_db_name" {
  default = "demords"
}
variable "mysql_db_username" {
  default = "demordsadmin"
}
variable "mysql_db_password" {
  default = "Uas38y3yQWha1gVxB"
}
variable "mysql_db_multi_az" {
  default = "true"
}
variable "mysql_db_port" {
  default = "3306"
}
