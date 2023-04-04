output "terraform-alb-dns-name" {
  value = aws_lb.terraform-lb.dns_name
  description = "The domain name of the load balancer"
}