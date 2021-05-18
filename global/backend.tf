terraform {
  backend "s3" {
    bucket = "infra.colinbruner.com"
    key    = "global/"
    region = "us-east-1"
  }
}
