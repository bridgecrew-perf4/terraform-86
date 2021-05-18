provider "aws" {
  region = var.aws_region
}

resource "aws_iam_policy" "s3_media_manage" {
  name        = "s3.media.manage"
  path        = "/"
  description = "s3 access for media bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:GetObjectAcl",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject",
          "s3:PutObjectAcl"
        ],
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::media.colinbruner.com/*",
          "arn:aws:s3:::media.colinbruner.com"
        ]
      }
    ]
  })
}

output "s3_media_manage_arn" {
  value = aws_iam_policy.s3_media_manage.arn
}
