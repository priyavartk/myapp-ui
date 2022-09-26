provider "aws" {
  region = var.aws_region
}


terraform {
  backend "s3" {
    bucket = "saas-logging-terraform"
    key = "terraform-ps.0"
    region = "us-west-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.29"
    }
  }
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}
