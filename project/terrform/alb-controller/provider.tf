# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.12"
    }
    helm = {
      source = "hashicorp/helm"
      #version = "2.5.1"
      version = "~> 2.5"
    }
    http = {
      source = "hashicorp/http"
      #version = "2.1.0"
      version = "~> 2.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.11"
    }
  }
  
  backend "s3" {
    bucket = "terraform-jaehan-state"
    key    = "alb/terraform.tfstate"
    region = "ap-northeast-2"

    dynamodb_table = "terraform_jaehan_locks"
    encrypt = true
  }
}

# Terraform AWS Provider Block
provider "aws" {
  region = var.aws_region
}

# Terraform HTTP Provider Block
provider "http" {
  # Configuration options
}

# Terraform Kubernetes Provider
provider "kubernetes" {
  host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "terraform-jaehan-state"
    key = "eks/terraform.tfstate"
    region = var.aws_region
   }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-jaehan-state"
    key = "vpc/terraform.tfstate"
    region = var.aws_region
   }
}