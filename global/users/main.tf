
provider "aws" {
  region = var.aws_region
}

locals {
  app_policy = data.terraform_remote_state.policy.outputs.s3_media_manage_arn
}

# Create a user named 'app.homepage' with minimal s3 access.
resource "aws_iam_user" "app_homepage" {
  name = "app.homepage"
}

# Attach s3 media manage policy from remote bucket
resource "aws_iam_user_policy_attachment" "app_homepage" {
  user       = aws_iam_user.app_homepage.name
  policy_arn = local.app_policy
}

