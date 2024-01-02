terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
  backend "s3" {
    bucket         = "shafiun26022023"
    key            = "terraform.tfstate"
    region         =  "us-east-1"

    #dynamodb_table = "LockID"
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}
resource "aws_vpc" "my_vpc" {
  #cidr_block = "10.0.0.0/16"  # Replace with your desired CIDR block
  cidr_block              = var.vpc_value
  enable_dns_support = true
  enable_dns_hostnames = true
  tags      = {
Name    = "my_vpc"
#vpc_id   =var.vpc_id
}
}
resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  #cidr_block              = "10.0.1.0/24"  # Replace with your desired subnet CIDR block
  cidr_block              = var.subnet_value
  availability_zone       = "us-east-1a"   # Replace with your desired availability zone
  map_public_ip_on_launch = true
  tags      = {
Name    = "public-subnet"
#subnet_id           =var.subnet_id
}
}
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
Name  = "internet_gateway"
}
}
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags       = {
Name     = "Public Route Table"
}
}

resource "aws_route_table_association" "my_subnet_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}
# Create Security Group 
resource "aws_security_group" "my_security_group" {
name        = "SSH Security Group"
description = "allow access on Ports 8080 and 22"
vpc_id      = aws_vpc.my_vpc.id
ingress {
description      = "SSH Access"
from_port        = 22
to_port          = 22
protocol         = "tcp"
cidr_blocks      = ["0.0.0.0/0"]
}
ingress {
description      = "Custom TCP Access"
from_port        = 8080
to_port          = 8080
protocol         = "tcp"
cidr_blocks      = ["0.0.0.0/0"]
}
egress {
from_port        = 0
to_port          = 0
protocol         = "-1"
cidr_blocks      = ["0.0.0.0/0"]
}
tags   = {
Name = "SSH Security Group"
}
}

#Create a new EC2 launch configuration
resource "aws_instance" "my_instance" {
ami                    = "ami-079db87dc4c10ac91"
instance_type               = var.instance_type
key_name                    = var.key_name
security_groups             = [aws_security_group.my_security_group.id]
subnet_id                   = aws_subnet.my_subnet.id
associate_public_ip_address = true
lifecycle {
create_before_destroy = true
}
tags = {
"Name" = "my_instance"
}
}
