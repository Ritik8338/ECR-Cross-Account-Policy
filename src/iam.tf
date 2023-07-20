## DATA BLOCKS
## ----------------------------------------------------------------

# Defining the SageMaker "Assume Role" policy
resource "aws_iam_role" "notebook_iam_role" {
  name = "sagemaker-assume-role"  # Replace with your desired role name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = ""
        Effect    = "Allow"
        Principal = {
          Service = "sagemaker.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
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