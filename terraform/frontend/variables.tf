variable "profile" {
  description = "AWS profile"
  type        = string
  default     = ""
}

variable "bucket_name" {
  description = "AWS S3 bucket name"
  type        = string
  default     = ""
}

variable "ssl_cert" {
  description = "Cloudfront SSL cert"
  type        = string
  default     = ""
}

variable "route53_zone_id" {
  description = "route53 zone id"
  type        = string
  default     = ""
}

variable "crc_url" {
  description = "cloud resume challenge url"
  type        = string
  default     = ""
}