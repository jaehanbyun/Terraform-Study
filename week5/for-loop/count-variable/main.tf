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
  count = length(var.user_names)
  name = var.user_names[count.index]
}

output "tom_arn" {
  value = aws_iam_user.my-user[*].arn
  description = "The ARN for user Neo"
}