
# Adding provider for Terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# AWS Provider configuration
provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

# Module for creating the VPC
module "vpccreate" {
  source              = "git@github.com:vinodhmvm/intchallenge.git//three-tier-architecture/tf-modules/vpc-stack"
  vpc_cdir_block      = var.aws_cidr_block
  public_subnet_1     = var.aws_public_subnet_1
  public_subnet_2     = var.aws_public_subnet_2
  private_subnet_3    = var.aws_private_subnet_3
  private_subnet_4    = var.aws_private_subnet_4
  availability_zone_A = var.aws_availability_zone_A
  availability_zone_B = var.aws_availability_zone_B
  any_ip              = var.aws_any_ip
}

# Module for creating the Web Instance
module "web-stack" {
  source          = "git@github.com:vinodhmvm/intchallenge.git//three-tier-architecture/tf-modules/ec2-stack"
  stackname       = "web"
  amis            = var.ami_id
  instance_type   = var.aws_instance_type
  vpc_id          = module.vpccreate.vpc_id
  public_subnet1  = module.vpccreate.out_publicsubnet1
#  public_subnet2  = module.vpccreate.out_publicsubnet2
  private_subnet3 = module.vpccreate.out_privatesubnet3
  private_subnet4 = module.vpccreate.out_privatesubnet4
  out_bastion_ssh = module.vpccreate.out_bastion_ssh
  max_asgp        = var.min_asg_value
  min_asgp        = var.max_asg_value
  out_alb_sg      = module.vpccreate.out_alb_sg
  out_ec2_sg      = module.vpccreate.out_ec2_sg
}

# Module for creating the App Instance
module "app-stack" {
  source          = "git@github.com:vinodhmvm/intchallenge.git//three-tier-architecture/tf-modules/ec2-stack"
  stackname       = "app"
  amis            = var.ami_id
  instance_type   = var.aws_instance_type
  vpc_id          = module.vpccreate.vpc_id
  public_subnet1  = module.vpccreate.out_publicsubnet1
#  public_subnet2  = module.vpccreate.out_publicsubnet2
  private_subnet3 = module.vpccreate.out_privatesubnet3
  private_subnet4 = module.vpccreate.out_privatesubnet4
  out_bastion_ssh = module.vpccreate.out_bastion_ssh
  max_asgp        = var.min_asg_value
  min_asgp        = var.max_asg_value
  out_alb_sg      = module.vpccreate.out_alb_sg
  out_ec2_sg      = module.vpccreate.out_ec2_sg
}

# Module for creating the DB Instance
module "db-stack" {
  source                    = "git@github.com:vinodhmvm/intchallenge.git//three-tier-architecture/tf-modules//rds-stack"
  db_allocated_storage      = var.db_allocated_storage
  db_storage_type           = var.db_storage_type
  db_engine                 = var.db_engine
  db_engine_version         = var.db_engine_version
  db_instance_class         = var.db_instance_class
  db_name                   = var.db_name
  db_username               = var.db_username
  db_password               = var.db_password
  db_multi_az               = var.db_multi_az
  db_port                   = var.db_port
  db_subnetgroup_name       = module.vpccreate.out_rdssubnetgroup
  db_vpc_security_group_ids = module.vpccreate.out_rdsmysqlsg
}