resource "aws_s3_bucket" "shon_diaz_assets" {
  bucket = "shon-diaz-assets-${var.environment}"
}
