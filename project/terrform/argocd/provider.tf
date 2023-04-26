provider "aws" {
  region = var.aws_region
}

data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "terraform-jaehan-state"
    key = "eks/terraform.tfstate"
    region = var.aws_region
   }
}