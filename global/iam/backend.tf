terraform {
  backend "s3" {
    bucket = "infra.colinbruner.com"
    key    = "global/iam/"
    region = "us-east-1"
  }
}
