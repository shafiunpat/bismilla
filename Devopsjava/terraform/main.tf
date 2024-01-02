terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
  backend "s3" {
    bucket         = "shafiun26022023"  # Replace with your S3 bucket name
    key            = "terraform.tfstate"
    region         = "us-east-1"  # Replace with your desired AWS region
    #encrypt        = true
    #dynamodb_table = "terraform_lock"  # Replace with your DynamoDB table name for state locking
  }
}
provider "aws" {
  # Configuration options
  region   = var.region  
}
# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
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
availability_zone       = "us-east-1a"
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
description = "Enable SSH and Custom TCP access on Port 22 and 8080"
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
subnet_id                   = aws_subnet.my_public_subnet.id
associate_public_ip_address = true
lifecycle {
create_before_destroy = true
}
tags = {
"Name" = "my_instance"
}
user_data = <<-EOF
#!/bin/bash
sudo yum update -y
sudo yum install docker -y
sudo service docker start
sudo service docker status
chmod 777 /var/run/docker.sock
docker pull jenkins/jenkins
docker run -it --name asma -p 8080:8080 -p 50000:50000 jenkins/jenkins
EOF
}
