# Fetch IAM policies
data "terraform_remote_state" "policy" {
  backend = "s3"
  config = {
    bucket = "infra.colinbruner.com"
    key    = "global/iam/"
    region = "us-east-1"
  }
}
