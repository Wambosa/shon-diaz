# It is tricky to centralize nameserver routing with multiple environments
# traditionally you have one set of nameservers that correspond with the registrar
# in our case we have lab/prod/registrar
# we therefore need the registrar to point to the prod nameservers
# AND we need the prod nameservers to point to subdomain var.environment

# this means that an aws_route53_record must be created for each environment,
# then when the environment is deployed, the nameservers for that environment becomes known
# only once the nameservers are known can they be included as variables for prod to deploy

resource "aws_route53_record" "shon_diaz_lab" {
  count   = "${var.environment == "prod" ? 1 : 0}"
  name    = "lab"
  ttl     = 60
  type    = "NS"
  zone_id = aws_route53_zone.shon_diaz.zone_id
  records = var.lab_nameservers
}
