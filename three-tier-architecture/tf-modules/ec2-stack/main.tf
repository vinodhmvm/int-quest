# Bastion EC2 Instance for accessing the instance in Private
resource "aws_instance" "bastion" {

    ami                         = var.amis
    instance_type               = var.instance_type
    subnet_id                   = var.public_subnet1
    associate_public_ip_address = true
    vpc_security_group_ids      = [var.out_bastion_ssh]

    tags                        = {
        Name = "${var.stackname}-Bastion"
    }    
}

# Elastic IP for Bastion Instance Creation
resource "aws_eip" "bastion_eip" {

    instance                    = aws_instance.bastion.id
    vpc                         = true
  
}
# AWS Launch Configuration to be used in ASG
resource "aws_launch_configuration" "asg_lc" {

    name                       = "${var.stackname}-lc"
    image_id                   = var.amis
    instance_type              = var.instance_type
    security_groups            = [
                                 var.out_alb_sg,
                                 var.out_bastion_ssh,
                                 var.out_ec2_sg
                                 ]

    associate_public_ip_address = true
    user_data                  = file("./user_data.sh")  
}
# AWS Autoscaling group for scaling up or down the instance
resource "aws_autoscaling_group" "ec2_asg" {

    name                 = "${var.stackname}-asg"
    max_size             = var.max_asgp
    min_size             = var.min_asgp
    launch_configuration = aws_launch_configuration.asg_lc.name
    target_group_arns    = [aws_lb_target_group.tg_create.arn]
    force_delete         = true
    vpc_zone_identifier  = [var.private_subnet3,var.private_subnet4]
    health_check_type    = "EC2"
    health_check_grace_period = 300
}
# AWS Load balancer for accessing ec2 instance distributed in two or more Availability zones
resource "aws_lb" "alb_create" {

    name               = "${var.stackname}-alb"
    load_balancer_type = "application"
    subnets            = [var.private_subnet3, var.private_subnet4] 
    security_groups    = [var.out_alb_sg]
    enable_deletion_protection = true
    tags               = {        
        Environment = "Application Load Balancer"
    }  
}
# AWS Load balancer Target group for adding the instance created via ASG launch configuration
resource "aws_lb_target_group" "tg_create" {
    name     = "${var.stackname}-tg"
    port     = 80
    protocol = "HTTP"
    target_type = "instance"
    vpc_id   = var.vpc_id    
}

# AWS Load balancer listener rule for making the LB listening on a specific port
resource "aws_lb_listener" "listener_create" {

    load_balancer_arn = aws_lb.alb_create.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.tg_create.arn 
    }  
}