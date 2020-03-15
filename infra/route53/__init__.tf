data "aws_caller_identity" "current" {}

locals {
  public_domain = "${var.environment == "prod" ? "" : "${var.environment}."}${var.domain_name}"
  s3_domain     = "${var.environment}.${var.domain_name}"
}

data "aws_s3_bucket" "shon_diaz" {
  bucket = local.s3_domain
}
