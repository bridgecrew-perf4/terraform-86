###
# s3 Configurations
###

resource "aws_s3_bucket" "homepage" {
  bucket = "colinbruner.com"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  # Enable versioning so we can see the full revision history of our state files
  versioning {
    enabled = false
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_policy" "homepage" {
  bucket = aws_s3_bucket.homepage.id

  policy = file("policies/public_read_object.json")
}


resource "aws_s3_bucket" "homepage_media" {
  acl = "public-read"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Create / Import
#TODO: develop.colinbruner.com.s3-website.us-east-2.amazonaws.com
