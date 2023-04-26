terraform {
  backend "s3" {
    bucket = "terraform-jaehan-state"
    key = "eks/terraform.tfstate"
    region = "ap-northeast-2"

    dynamodb_table = "terraform_jaehan_locks"
    encrypt = true
  }
}

provider "aws" {
  profile = "example"
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  exclude_names = ["ap-northeast-2a","ap-northeast-2c"]
}

data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config = {
    bucket = "terraform-jaehan-state"
    key = "vpc/terraform.tfstate"
    region = var.aws_region
   }
}