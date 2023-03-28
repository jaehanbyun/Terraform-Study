resource "aws_instance" "example" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.instance.id]
  subnet_id = aws_subnet.terraform-subnet1.id

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Name = "terraform-example"
  }
}

output "ec2_public_ip" {
  value = aws_instance.example.public_ip
  description = "The public IP of the instance"
}