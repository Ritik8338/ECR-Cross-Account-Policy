terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.8.0"
    }
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bhghigygucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}