locals {
  root_vanity = "${var.environment == "prod" ? "" : "${var.environment}."}${var.domain_name}"
  s3_domain   = "${var.environment}.${var.domain_name}"
}
