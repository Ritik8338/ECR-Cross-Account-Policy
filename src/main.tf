provider "aws" {
  region = "us-west-2"  # Replace with your desired AWS region
}

resource "aws_ecr_repository" "foo" {
  name                 = "docker_demo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
