locals {
  server_port = 8080
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_instance" "example" {
  ami                    = "ami-0e38c97339cddf4bd"
  instance_type          = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p \${local.server_port} &
              EOF

  tags = {
    Name = "terraform-${var.server_name}-example"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = local.server_port
    to_port     = local.server_port
    protocol    = local.protocol
    cidr_blocks = local.cidr_blocks
  }
}