provider "aws" { 
    alias = "account2" 
    region = "us-west-2" 
    access_key = "AKIAUYQQOC77X5VYDZHN" 
    secret_key = "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" 
} 

data "aws_iam_user" "imported_user" { 
    provider = aws.account2 
    name = "cross_account_user" 
} 

data "aws_iam_policy_document" "cross_account_policy" { 
    provider = aws.account2 
    statement { 
        actions = ["ecr:GetDownloadUrlForLayer", "ecr:BatchGetImage", "ecr:GetAuthorizationToken"] 
        resources = ["arn:aws:ecr:us-west-2:575773971780:repository/docker_demo_ab"] 
    } 
}

resource "aws_iam_policy" "cross_account_policy" { 
    provider = aws.account2 
    name = "ECRCrossAccountPolicy" 
    description = "Allows cross-account ECR access" 
    policy = data.aws_iam_policy_document.cross_account_policy.json 
} 

resource "aws_iam_role_policy_attachment" "cross_account_policy_attachment" { 
    provider = aws.account2 
    policy_arn = aws_iam_policy.cross_account_policy.arn 
    user = aws_iam_user.imported_user.name 
}