provider "aws" {
  profile = "example"
  region = "ap-northeast-2"
}

resource "aws_iam_user" "my-user" {
  count = 3
  name = "jaehan.${count.index}"
}


