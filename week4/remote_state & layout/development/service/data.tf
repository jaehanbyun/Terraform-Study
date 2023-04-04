data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    profile = "example"
    bucket = "terraform-jaehan-state"
    key = "development/db/terraform.tfstate"
    region = "ap-northeast-2"
   }
}

data "template_file" "user_data" {
  template = file("./user-data.sh")

  vars = {
    server_port = var.server_port
    db_address = data.terraform_remote_state.db.outputs.address
    db_port = data.terraform_remote_state.db.outputs.port
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]
    
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }
    
  filter {
    name  = "owner-alias"
    values = ["amazon"]
  }
}

output "latest_ami_id" {
  value = data.aws_ami.ubuntu.id
  description = "The AMI ID latest ubuntu 22.04 verison"
}