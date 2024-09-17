variable "profile" {
  description = "AWS profile"
  type        = string
  default     = ""
}

variable "db_arn" {
  description = "AWS DynamboDB arn"
  type        = string
  default     = ""
}

variable "crc_url" {
  description = "cloud resume challenge url"
  type        = string
  default     = ""
}