provider "aws" {
  profile = "example"
  region = "ap-northeast-2"
}  

resource "aws_s3_bucket" "terraform-state" {
  bucket = "terraform-jaehan-state"

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
    }
  }
}