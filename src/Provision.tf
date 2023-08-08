resource "aws_sagemaker_feature_group" "example" {
  feature_group_name             = "example"
  record_identifier_feature_name = "example"
  event_time_feature_name        = "example"
  role_arn                       = aws_iam_role.feature_store_role.arn

  feature_definition {
    feature_name = "example"
    feature_type = "String"
  }

  online_store_config {
    enable_online_store = true
  }
}

resource "aws_iam_role" "provider_account_role" {
  name = "SagemakerFeatureStoreAccessRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "arn:aws:iam::575773971780:root"    # Replace ACCOUNT_B_ID
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "provider_account_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFeatureStoreAccess"
  role       = aws_iam_role.provider_account_role.name
}



resource "aws_iam_role" "consumer_account_role" {
  name = "SagemakerFeatureStoreConsumerRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "arn:aws:iam::327525734399:root"    # Replace ACCOUNT_A_ID
        }
      },
    ]
  })
}