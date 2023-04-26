output "vpc" {
  value = aws_vpc.my-vpc.id
}

output "public-a" {
  value = aws_subnet.public-a.id
}

output "public-c" {
  value = aws_subnet.public-c.id
}