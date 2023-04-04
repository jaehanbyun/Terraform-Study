resource "aws_db_instance" "jaehan_db"{
  identifier_prefix = "jaehan"
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t2.micro"
  name = "terraform_db"

  username = "admin"
  password = var.db_password

  skip_final_snapshot = true
  final_snapshot_identifier = "jaehan-db-final-snapshot"
}

# data "aws_secretsmanager_secret_version" "db_password" {
#   secret_id = "terraform/mysql/password"
# }

# output "passwd" {
#   value = data.aws_secretsmanager_secret_version.db_password.secret_string
#   sensitive = true
# }