terraform {
  required_version = ">= 1.0"
}

provider "aws" {
  profile = "example"
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  exclude_names = ["ap-northeast-2a","ap-northeast-2c"]
}