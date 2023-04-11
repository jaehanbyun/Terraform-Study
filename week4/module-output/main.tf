provider "aws" {
  profile = "example"
  region = "ap-northeast-2"
}

module "ec2-module" {
  source = "./ec2-module"

  server_name = "jaehan-vm"
}

output "module-output_ip" {
  value       = module.ec2-module.public_ip
  description = "The public IP of the Instance"
}