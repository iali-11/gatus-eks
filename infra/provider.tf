terraform {
  required_version = ">= v1.15.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.63.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~>3.3.0"
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
  region = var.aws_region
}

provider "helm" {
  kubernetes = {
    host                   = module.eks.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.eks_cluster_certificate_authority_data)
    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.eks_cluster_name, "--region", var.aws_region]
      command     = "aws"
    }
  }
}