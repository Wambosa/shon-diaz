variable "domain_name" {
  default = "shondiaz.com"
}

variable "lab_nameservers" {
  type = list(string)

  default = [
    "todo",
  ]
}

variable "region" {
  default = "us-east-1"
}

variable "environment" {
  default = "lab"
}

terraform {
  required_version = ">= 0.12"
  backend "s3" {
    acl    = "private"
    key    = "shon-diaz/route53/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}
