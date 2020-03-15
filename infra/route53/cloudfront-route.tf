resource "aws_route53_record" "shon_diaz_cloudfront" {
  zone_id = aws_route53_zone.shon_diaz.zone_id
  name    = local.public_domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.shon_diaz.domain_name
    zone_id                = aws_cloudfront_distribution.shon_diaz.hosted_zone_id
    evaluate_target_health = false
  }
}
