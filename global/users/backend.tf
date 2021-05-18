terraform {
  backend "s3" {
    bucket = "infra.colinbruner.com"
    key    = "global/users"
    region = "us-east-1"
  }
}
