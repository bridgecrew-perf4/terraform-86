
provider "aws" {
  region = var.aws_region
}

locals {
  # Policy for access to media.colinbruner.com
  media_policy = data.terraform_remote_state.policy.outputs.s3_media_manage_arn
  # Policy for access to [develop.]colinbruner.com
  cicd_policy = data.terraform_remote_state.policy.outputs.s3_homepage_manage_arn

  policies = [local.media_policy, local.cicd_policy]
}

###
# CICD User
###

# Create a user named 'homepage.cicd' for required s3 access.
resource "aws_iam_user" "homepage_cicd" {
  name = "homepage.cicd"
}

# Attach s3 policy to new user
resource "aws_iam_user_policy_attachment" "homepage_media" {
  for_each = toset(local.policies)

  user       = aws_iam_user.homepage_cicd.name
  policy_arn = each.key
}
