#Bastion Security Group Creation for allowing the external user login to the instance via ssh
resource "aws_security_group" "bastion_ssh_sg" {    
    name            = "bastion_ssh_all_sg"
    description     = "Allow SSH from Anywhere"
    vpc_id          = aws_vpc.vpc_create.id
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.any_ip]
    }
    egress {
        from_port   = "0"
        to_port     = "0"
        protocol    = "-1"
        cidr_blocks = [var.any_ip]
    }
    tags            = {        
        Name = "BastionAllowAll"
    }  
}
output "out_bastion_ssh" {
  value = aws_security_group.bastion_ssh_sg.id
}

#Allowing SSH for Bastion
resource "aws_security_group" "bastion_ssh_from_nat" {
    name             = "ssh_from_bastion_nat"
    description      = "Allow SSH from Bastion Host"
    vpc_id           = aws_vpc.vpc_create.id 
    ingress {
     from_port       = 22
     to_port         = 22
     protocol        = "tcp"
     security_groups = [
                        aws_security_group.bastion_ssh_sg.id,
                        aws_security_group.web_from_nat_prv_sg.id

     ]
    }  
}
output "bastion_ssh_from_nat" {
  value = aws_security_group.bastion_ssh_from_nat.id
}
# Application Load Balancer Security Group
resource "aws_security_group" "external_alb_sg" {
    name        = "alb_sg"
    description = "Allow port 80 from Anywhere"
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = [var.any_ip]
    }
    egress {
        from_port   = "0"
        to_port     = "0"
        protocol    = "-1"
        cidr_blocks = [var.any_ip]

    }
    tags            = {
        Name = "alb_sg"
    }
    vpc_id          = aws_vpc.vpc_create.id  
}
output "out_alb_sg" {
  value = aws_security_group.external_alb_sg.id
}

# Security Group Creation of EC2
resource "aws_security_group" "web_outbound_sg" {
    name            = "ec2_outbound"
    description     = "Allow Outbound Connections"
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [var.any_ip]
    }
    vpc_id          = aws_vpc.vpc_create.id 
}
output "out_ec2_sg" {
  value = aws_security_group.web_outbound_sg.id
}
# Security Group Creation of RDS DB
resource "aws_security_group" "databasesg" {
    name                    = "database_security_group"
    description             = "Allow Web Access to RDS MySQL"
    vpc_id                  = aws_vpc.vpc_create.id
    ingress {
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        cidr_blocks     = [aws_subnet.privatesubnet3.cidr_block]
    }
    ingress {
        from_port       = -1
        to_port         = -1
        protocol        = "icmp"
        cidr_blocks     = [aws_subnet.privatesubnet3.cidr_block]
    }
    ingress {
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        cidr_blocks     = [aws_subnet.privatesubnet4.cidr_block]
    }
    ingress {
        from_port       = -1
        to_port         = -1
        protocol        = "icmp"
        cidr_blocks     = [aws_subnet.privatesubnet4.cidr_block]
    }
    egress {
        from_port       = 0
        to_port         = 0
        protocol        = -1
        cidr_blocks     = [var.any_ip]
    }
    tags = {
        Name = "mysqldbsg"
    }  
}
output "out_rdsmysqlsg" {
  value = aws_security_group.databasesg.id
}

