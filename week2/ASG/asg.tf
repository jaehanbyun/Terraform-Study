resource "aws_launch_configuration" "jaehan-launconfig" {
  image_id = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.jaehan-sg.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p \${var.server_port} &
              EOF

  # Autu Scaling Group에서 시작 구성을 사용할 때 필요
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "jaehan-asg" {
    launch_configuration = aws_launch_configuration.jaehan-launconfig.name
    availability_zones = ["ap-northeast-2a", "ap-northeast-2c"]

    min_size = 2
    max_size = 5

    tag {
        key = "name"
        value = "terraform-jaehan-asg"
        propagate_at_launch = true
    }
}
