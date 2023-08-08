resource "aws_iam_role" "ecr_cross_account_role" {
  name = "ECRCrossAccountRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::327525734399:root"  #Account B's AWS account ID
        }
      }
    ]
  })
}

resource "aws_iam_policy" "ecr_cross_account_policy" {
  name        = "ECRCrossAccountPolicy"
  description = "Policy to allow pulling ECR images from Account A"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["ecr:GetDownloadUrlForLayer", "ecr:BatchGetImage", "ecr:BatchCheckLayerAvailability"],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ecr_cross_account_attachment" {
  name       = "ECRCrossAccountAttachment"
  roles      = [aws_iam_role.ecr_cross_account_role.name]
  policy_arn = aws_iam_policy.ecr_cross_account_policy.arn
}

resource "aws_ecr_repository_policy" "cross_account_ecr_policy" {
  repository = "docker_demo"  

  policy = jsonencode({
    Version = "2008-10-17",
    Statement = [
      {
        Sid       = "CrossAccountAccess",
        Effect    = "Allow",
        Principal = {
          AWS = "arn:aws:iam::327525734399:role/ECRCrossAccountRole"  # Account B's AWS account ID
        },
        Action    = "ecr:*",
        Resource  = aws_ecr_repository.cross_account_ecr.arn
      }
    ]
  })
}

resource "aws_ecr_repository" "cross_account_ecr" {
  name = "docker_demo"  
}
