resource "aws_dynamodb_table" "terraform_locks" {
  name = "terraform_jaehan_locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of DynamoDB table"
}