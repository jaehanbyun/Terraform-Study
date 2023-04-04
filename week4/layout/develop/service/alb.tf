resource "aws_lb" "terraform-lb" {
    name = "terraform-lb"
    load_balancer_type = "application"
    subnets = [aws_subnet.terraform-subnet1.id, aws_subnet.terraform-subnet2.id]
    security_groups = [aws_security_group.terraform-alb-sg.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.terraform-lb.arn
  port = 80
  protocol = "HTTP"

  # 기본값으로 단순한 404 페이지 오류를 반환합니다.
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code = 404
    }
  }
}

resource "aws_security_group" "terraform-alb-sg" {
  name = "terraform-alb-sg"
  vpc_id = aws_vpc.terraform-vpc.id

  # 인바운드 "HTTP" 트래픽 허용
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 모든 아웃바운드 트래픽 허용 - 로드밸런서가 health check를 수행하기 위함
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "terraform-alb-tg" {
  name = "terraofrm-alb-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.terraform-vpc.id

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 15
    timeout = 3
    healthy_threshold = 2
    unhealthy_threshold = 2
  } 
}

resource "aws_lb_listener_rule" "terraform-lbrule" {
  listener_arn = aws_lb_listener.http.arn
  priority = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.terraform-alb-tg.arn
  }
}
