#Vpc
#internet gateway
#nat gateway--> Elastic ip and public subnet
#public subnet 
#private subnet
#public route tables--> associate to public subnet
#private route tables--> associate to private subnet
#private route --> add route to route the traffic to nat gateway
#public route--> add route to route the traffic to internet gateway

provider "aws" {
    region = "us-east-1"

}

#Below block for createing vpc
resource "aws_vpc" "dpt4_vpc" {
  cidr_block = "192.168.0.0/16"
  
  tags = {
    Name = "Dpt4_VPC"
  }
}

# below block for internat gateway
resource "aws_egress_only_internet_gateway" "example" {
  vpc_id = aws_vpc.dpt4_vpc.id

  tags = {
    Name = "dpt4_intrnate_gateway"
  }
}

#below block for nat gateway
resource "aws_nat_gateway" "dpt2_web" {
  allocation_id = aws_eip.dpt2_web.id
  subnet_id     = aws_subnet.dpt4_pub_subnet.id

  tags = {
    Name = "dpt4 NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.example]
} 

# elastic ip
resource "aws_ip" "dpt4-web" {
  
}

# creating public subent
resource "aws_subnet" "dpt4_pub_subnet" {
  vpc_id     = aws_vpc.dpt4_vpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "dpt4_pubsub"
  }
}

# creating private subnet
resource "aws_subnet" "dpt4_pri_subnet" {
  vpc_id     = aws_vpc.dpt4_vpc.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "dpt4_privsub"
  }
}

# creating  public route table
resource "aws_route_table" "dpt_pub_route" {
  vpc_id = aws_vpc.dpt4_vpc.id

  tags = {
    Name = "dpt4_pub_rutetable"
  }
}

# creating private route table
resource "aws_route_table" "dpt_private_route" {
  vpc_id = aws_vpc.dpt4_vpc.id

  tags = {
    Name = "dpt4_prvt_rttble"
  }
}

# route table association 
resource "aws_route_table_association" "dpt4_pub_route_asstion" {
  subnet_id      = aws_subnet.dpt4_pub_subnet.id
  route_table_id = aws_route_table_association.dpt4_private_route_asstion.id
}
resource "aws_route_table_association" "dpt4_private_route_asstion" {
  subnet_id     = aws_subnet.dpt4_pri_subnet.id
  route_table_id = aws_route_table.dpt_private_route.id
}

#private route -->add route to route the traffic to nat gateway
resource "aws_route" "dpt4_priv_nat" {
  route_table_id            = aws_route_table.dpt_private_route.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.dpt2_web.id
  depends_on                = [aws_route_table.testing]
}

#public route -->add route to route the traffic to internat gateway
resource "aws_route" "dpt4_pub_intergatway" {
  route_table_id            = aws_route_table.dpt_pub_route.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.dpt2_web.id
  depends_on                = [aws_route_table.testing]
}


# spilt into a subnets.tf and natgtway.tf and routetbles.tf and eip.tf
# store all some variables in terraform.tfvars file like region,destination_cidr_block,
#vpc_cidr_block,pub_cidr_block,pub_availability_zone,private_block,prvt_availability_zone