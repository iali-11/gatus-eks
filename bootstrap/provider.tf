terraform {
  required_version = ">= v1.15.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.63.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}