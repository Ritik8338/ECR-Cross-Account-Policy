terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.8.0"
    }
  }
}

provider "aws" {
  AWS_ACCESS_KEY = "AKIAYMDWNSVCFVGWL35K"
  AWS_SECRET_ACCESS_KEY = "wa3jf1OtO7PFKkUYZK0GJ314VFvWwBfSRYrMUnRz"
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bhghigygucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
