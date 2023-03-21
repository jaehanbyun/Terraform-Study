resource "aws_launch_configuration" "terraform-launconfig" {
  image_id = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.terraform-sg.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p \${var.server_port} &
              EOF

  # Auto Scaling Group에서 시작 구성을 사용할 때 필요
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "terraform-asg" {
    launch_configuration = aws_launch_configuration.terraform-launconfig.name
    vpc_zone_identifier = [aws_subnet.terraform-subnet1.id, aws_subnet.terraform-subnet2.id]

    min_size = 2
    max_size = 5

    tag {
        key = "name"
        value = "terraform-asg"
        propagate_at_launch = true
    }
}
