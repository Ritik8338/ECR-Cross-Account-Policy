resource "aws_iam_role" "feature_store_role" {
  name = "FeatureStoreRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "sagemaker.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "feature_store_policy" {
  name = "FeatureStorePolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "sagemaker:CreateFeatureGroup",
          "sagemaker:DescribeFeatureGroup",
          "sagemaker:ListFeatureGroups",
          "sagemaker:DeleteFeatureGroup",
          "sagemaker:CreateFeature",
          "sagemaker:CreateDataset",
          "sagemaker:DeleteFeature",
          "sagemaker:DeleteDataset",
          "sagemaker:UpdateFeatureGroup",
          "sagemaker:BatchWriteFeatureGroup",
          "sagemaker:GetRecord",
          "s3:GetObject",
          "s3:ListBucket",
          "glue:GetTable",
          "glue:GetTableVersion",
          "glue:GetTableVersions",
          "glue:CreateTable",
          "glue:UpdateTable",
          "glue:DeleteTable",
          "glue:BatchCreatePartition",
          "glue:BatchDeletePartition"
        ],
        Effect = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "feature_store_policy_attachment" {
  policy_arn = aws_iam_policy.feature_store_policy.arn
  role       = aws_iam_role.feature_store_role.name
}



