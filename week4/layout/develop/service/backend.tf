terraform {
  backend "s3" {
    profile = "example"
    bucket = "terraform_jaehan_state"
    key    = "terraform.tfstate"
    region = "ap-northeast-2"

    dynamodb_table = "terraform_jaehan_locks"
    encrypt = true
  }

}