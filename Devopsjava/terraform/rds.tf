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
resource "aws_db_instance" "default" {
  allocated_storage = 10
  engine = "mysql"
  instance_class = "db.t3.micro"
  username = "foo"
  password = "foobarbaz"
  skip_final_snapshot = true // required to destroy
}