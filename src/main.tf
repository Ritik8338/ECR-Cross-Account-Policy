provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bhghigygucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
