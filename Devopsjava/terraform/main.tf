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
    region         = "ap-south-1"
    dynamodb_table = "LockID"
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}