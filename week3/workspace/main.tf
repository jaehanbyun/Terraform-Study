provider "aws" {
  profile = "example"
  region = "ap-northeast-2"
}

terraform {
  backend "s3" {
    profile = "example"
    bucket = "terraform-jaehan-state"
    key = "workspace/terraform.tfstate"
    region = "ap-northeast-2"

    dynamodb_table = "terraform-jaehan-locks"
    encrypt = true
  }
}

resource "aws_instance" "jaehan-example" {
  ami = "ami-04cebc8d6c4f297a3"
  instance_type = "t2.micro"
}