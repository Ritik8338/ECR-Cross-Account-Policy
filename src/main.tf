provider "aws" {
   region = "us-west-2" 
} 

resource "aws_instance" "foo" { 
  ami = "ami-04e35eeae7a7c5883" # us-west-2 
  instance_type = "t2.micro" 
  
  tags = { 
    name = "EcrTestInstance" 
  } 
} 

resource "aws_ecr_repository" "account_a_repo" { 
  name = "docker_demo_ab" 
} 

resource "aws_ecr_repository_policy" "account_a_repo_policy" { 
  repository = aws_ecr_repository.account_a_repo.name 
  
  policy = jsonencode({ 
    Version = "2012-10-17", Statement = [ 
      { 
        Sid = "CodeBuildAccess", 
        Effect = "Allow", 
        Principal = { 
          AWS = "arn:aws:iam::327525734399:user/cross_account_user" # Replace <Account_B_ID> with Account B's AWS account ID 
        }, 
        Action = "ecr:*", 
      }, 
    ],
  }) 
}