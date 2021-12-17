#AWS Internet Gateway creation for Internet enabled machines
resource "aws_internet_gateway" "gw" {
        vpc_id = aws_vpc.vpc_create.id
        tags   = {
        Name   = "igw"
        }  
}
output "output_igw" {
  value          = aws_internet_gateway.gw.id
}
#AWS EIP Creation for NAT Gateway Service
resource "aws_eip" "natgweip" {
    vpc = true  
}

#AWS NAT Gateway Service Creation for the private instance outbound access to Internet
resource "aws_nat_gateway" "natgw" {
    subnet_id     = aws_subnet.publicsubnet2.id
    depends_on    = [aws_internet_gateway.gw]
    allocation_id = aws_eip.natgweip.id
    tags          = {
      Name          = "natgw"
    }
}



