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
  #region   = var.region  
}
