terraform {
  backend "s3" {
    bucket         = "shafiun26022023"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "LockID"
  }
}

  /* required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.55.0"
    }
  } */
provider "aws" { 
  # Configuration options
  region = var.region
}

# Create VPC
resource "aws_vpc" "my_vpc" {
cidr_block = "10.0.0.0/16"
enable_dns_hostnames    = true
tags      = {
Name    = "my_VPC"
}
}
# Create Internet Gateway
resource "aws_internet_gateway" "my_internet_gateway" {
vpc_id    = aws_vpc.my_vpc.id
tags = {
Name  = "internet_gateway"
}
}
# Create Public Subnet
resource "aws_subnet" "my_public_subnet" {
vpc_id                  = aws_vpc.my_vpc.id
cidr_block              = "10.0.0.0/24"
availability_zone       = "ap-south-1b"
map_public_ip_on_launch = true
tags      = {
Name    = "public-subnet"
}
}
# Create Route Table
resource "aws_route_table" "my_public_route_table" {
vpc_id       = aws_vpc.my_vpc.id
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.my_internet_gateway.id
}
tags       = {
Name     = "Public Route Table"
}
}
# Associate Public Subnet
resource "aws_route_table_association" "my_public_subnet_route_table_association" {
subnet_id           = aws_subnet.my_public_subnet.id
route_table_id      = aws_route_table.my_public_route_table.id
}

# Create Security Group 
resource "aws_security_group" "my_security_group" {
name        = "SSH Security Group"
description = "Enable SSH access on Port 22"
vpc_id      = aws_vpc.my_vpc.id
ingress {
description      = "SSH Access"
from_port        = 22
to_port          = 22
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
ami                    = "ami-0e742cca61fb65051"
instance_type               = var.instance_type
key_name                    = var.key_name
security_groups             = [aws_security_group.my_security_group.id]
subnet_id                   = aws_subnet.my_public_subnet.id
associate_public_ip_address = true
lifecycle {
create_before_destroy = true
}
tags = {
"Name" = "my_instance"
}
}