provider "aws" {
  profile = "example"
  region = "ap-northeast-2"
}

variable "user_names" {
  description = "Create IAM users with these names"
  type = list(string)
  default = [ "jaehan", "tom", "jerry" ]
}

resource "aws_iam_user" "my-user" {
  for_each = toset(var.user_names)
  name = each.value 
}

output "all_user_arn" {
  value = values(aws_iam_user.my-user)[*].arn
}