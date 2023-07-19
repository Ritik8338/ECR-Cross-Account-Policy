## DATA BLOCKS
## ----------------------------------------------------------------

# Defining the SageMaker "Assume Role" policy
data "aws_iam_policy_document" "sm_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    
    principals {
      type = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}



## RESOURCE BLOCKS
## ----------------------------------------------------------------

# Defining the SageMaker notebook IAM role
resource "aws_iam_role" "notebook_iam_role" {
  assume_role_policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "Stmt1590217939125",
        "Action": "s3:*",
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::wwe"
      },
      {
        "Sid": "Stmt1590217939125",
        "Action": "s3:*",
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::wwe/*"
      },
      {
        "Sid": "Stmt1577967806846",
        "Action": [
          "secretsmanager:DescribeSecret",
          "secretsmanager:GetRandomPassword",
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:ListSecretVersionIds",
          "secretsmanager:ListSecrets"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
}
  EOF
  tags = {
    Name        = wwe
    Environment = STAGE
  }
}


## RESOURCE BLOCKS
## ----------------------------------------------------------------

# Defining the SageMaker notebook IAM role


# Attaching the AWS default policy, "AmazonSageMakerFullAccess"
resource "aws_iam_policy_attachment" "sm_full_access_attach" {
  name = "sm-full-access-attachment"
  roles = [aws_iam_role.notebook_iam_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}
