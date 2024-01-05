terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}
provider "aws" {
  # Configuration options
  region   = "us-east-1"  
}

resource "aws_kms_key" "example_kms_key" {
  description = "Example KMS Key"
}

resource "aws_db_instance" "example_rds" {
  identifier           = "example-rds-instance"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "admin_user"
  password             = "your_password_here"
  #name                 = "exampledb"
  port                 = 3306
  publicly_accessible = false

  kms_key_id = "arn:aws:kms:us-east-1:151854138445:key/791a6944-573a-4695-a583-844a0f055c4d"

  tags = {
    Name = "example-rds-instance"
  }
}
