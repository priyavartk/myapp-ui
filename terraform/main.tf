provider "aws" {
  region = var.aws_region
}


terraform {
  backend "local" {
    path = "/tmp/terraform.tfstate"
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
