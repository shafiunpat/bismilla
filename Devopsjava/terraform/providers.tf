terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias = "replica"
}

resource "aws_db_instance_automated_backups_replication" "default" {
  source_db_instance_arn = aws_db_instance.default.arn
  retention_period = 14
  kms_key_id = aws_kms_key.my_kms_key_us_east.arn

  provider = aws.replica
}
resource "aws_kms_key" "my_kms_key_us_east" {
  description = "My KMS Key for RDS Encryption"
  deletion_window_in_days = 30

  tags = {
    Name = "MyKMSKey"
  }

  provider = aws.replica
}