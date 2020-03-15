variable "domain_name" {
  default = "shondiaz.com"
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
    key    = "shon-diaz/website/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}
