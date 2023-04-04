terraform {
  backend "s3" {
    profile = "example"
    bucket = "terraform-jaehan-state"
    key    = "development/service/terraform.tfstate"
    region = "ap-northeast-2"

    dynamodb_table = "terraform-jaehan-locks"
    encrypt = true
  }
}