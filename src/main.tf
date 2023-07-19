provider "aws" {
  region = "us-west-2"  # Replace with your desired AWS region
}

resource "aws_iam_role" "lambda_role" {
  name = "my-lambda-role"  # Replace with your desired role name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = ""
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_lambda_layer_version" "python_layer" {
  filename   = "modules/layer.zip"  # Replace with the path to your ZIP file
  layer_name = "my-python-layer"
  compatible_runtimes = ["python3.8"]  # Replace with the desired Python runtime version
}

resource "aws_lambda_function" "example_lambda" {
  filename         = "modules/lambda.zip"
  function_name    = "example_lambda_function"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.handler"
  runtime          = "python3.8"
  layers           = [aws_lambda_layer_version.python_layer.arn]  # Reference the Python layer ARN here
}