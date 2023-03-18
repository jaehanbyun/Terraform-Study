data "aws_ami" "ubuntu" {
    most_recent = true

    owners = ["099720109477"]
    
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
    }
    
    filter {
        name   = "owner-alias"
        values = ["amazon"]
    }
}

output "latest_ami_id" {
    value = data.aws_ami.ubuntu.id
    description = "The AMI ID latest ubuntu 22.04 verison"
}