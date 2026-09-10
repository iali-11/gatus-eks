terraform {
  required_version = ">= v1.15.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.63.0"
    }
  }
  backend "s3" {
    bucket       = "gatus-eks-backend"
    key          = "terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  region = "eu-west-2"
}