provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    profile = "example"
    bucket = "terraform-jaehan-state"
    key = "vpc/terraform.tfstate"
    region = "ap-northeast-2"

    dynamodb_table = "terraform_jaehan_locks"
    encrypt = true
  }
}
