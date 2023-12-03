# vpc 생성
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}

# 서브넷 생성
resource "aws_subnet" "public-a" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "ap-northeast-2a"

    tags = {
      Name = "my-public-subnet-a"
      "kubernetes.io/cluster/${var.cluster-name}" = "shared"
      "kubernetes.io/role/elb" = "1"
    }
}

resource "aws_subnet" "public-c" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "my-public-subnet-c"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    "kubernetes.io/role/elb" = "1"
  }
}

# 인터넷 게이트웨이 생성
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-igw"
  }
}

# 라우팅 테이블 생성
resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    Name = "my-route-table"
  }
}

# 라우팅 테이블과 서브넷 연결
resource "aws_route_table_association" "public-a-association" {
  subnet_id = aws_subnet.public-a.id
  route_table_id = aws_route_table.my-route-table.id
}

resource "aws_route_table_association" "public-c-association" {
  subnet_id = aws_subnet.public-c.id
  route_table_id = aws_route_table.my-route-table.id
}
