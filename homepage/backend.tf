terraform {
  backend "s3" {
    bucket = "infra.colinbruner.com"
    key    = "homepage/"
    region = "us-east-1"
  }
}
