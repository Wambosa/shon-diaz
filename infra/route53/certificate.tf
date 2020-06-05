resource "aws_acm_certificate" "shon_diaz" {
  domain_name               = "*.${local.public_domain}"
  validation_method         = "DNS"
  subject_alternative_names = ["${local.public_domain}"]
}

resource "aws_route53_record" "shon_diaz_cert_validation" 
  name    = aws_acm_certificate.shon_diaz.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.shon_diaz.domain_validation_options.0.resource_record_type
  zone_id = aws_route53_zone.shon_diaz.id
  records = ["${aws_acm_certificate.shon_diaz.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "shon_diaz" {
  certificate_arn         = aws_acm_certificate.shon_diaz.arn
  validation_record_fqdns = ["${aws_route53_record.shon_diaz_cert_validation.fqdn}"]
}
