provider "aws" {
  region = "us-east-1"
  profile = var.profile
}

resource "aws_s3_bucket" "sitebucket" {
  bucket = var.bucket_name

  tags = {
    deploy        = "terraform"
  }

}

resource "aws_s3_bucket_website_configuration" "siteconfig" {
  bucket = aws_s3_bucket.sitebucket.id

  index_document {
    suffix = "index.html"
  }

  routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": ""
    }
}]
EOF
}

locals {
  s3_origin_id = ""
}

resource "aws_cloudfront_origin_access_control" "cloudfrontoac" {
  name                              = "s3oacterraform"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.sitebucket.id

  policy = jsonencode({
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipal",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.sitebucket.arn}/*",
            "Condition": {
                "StringEquals": {
                  "AWS:SourceArn": aws_cloudfront_distribution.cloudfrontcdn.arn
                }
            }
        }
    ]
  })
}

resource "aws_cloudfront_distribution" "cloudfrontcdn" {
  origin {
    domain_name              = aws_s3_bucket.sitebucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.cloudfrontoac.id
    origin_id                = local.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = [var.crc_url]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

    # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "https-only"
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/content/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "https-only"
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    deploy = "terraform"
  }

  viewer_certificate {
    acm_certificate_arn            = var.ssl_cert
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
  }
}

resource "aws_route53_record" "cloudfront_record" {
  zone_id = var.crc_url
  name    = var.
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cloudfrontcdn.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfrontcdn.hosted_zone_id
    evaluate_target_health = false
  }
}