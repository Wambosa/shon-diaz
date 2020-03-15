resource "aws_s3_bucket" "shon_diaz" {
  bucket = "${local.s3_domain}"
  acl    = "public-read"
  policy = "${data.template_file.shon_diaz_policy.rendered}"

  website {
    index_document = "index.html"
    error_document = "error.html"
    routing_rules  = "${data.template_file.routing_rules.rendered}"
  }
}

data "template_file" "shon_diaz_policy" {
  template = "${file("${path.module}/policy/s3-website.json")}"

  vars = {
    root = "${local.s3_domain}"
  }
}

data "template_file" "routing_rules" {
  template = "${file("${path.module}/policy/routing-rules.json")}"

  vars = {
    vanity = "${local.root_vanity}"
  }
}
