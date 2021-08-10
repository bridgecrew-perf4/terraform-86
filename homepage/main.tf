provider "aws" {
  region = var.aws_region
}

###
# CloudFront Distribution Configurations
###

resource "aws_cloudfront_origin_access_identity" "homepage" {}

resource "aws_cloudfront_distribution" "homepage" {
  enabled = true
  comment = "Homepage Media Distribution"

  price_class     = "PriceClass_100"
  is_ipv6_enabled = false

  origin {
    domain_name = aws_s3_bucket.homepage_media.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.homepage_media.bucket_regional_domain_name
    origin_path = "/processed_images"

    connection_attempts = 3
    connection_timeout  = 10

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.homepage.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.homepage_media.bucket_regional_domain_name

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}



