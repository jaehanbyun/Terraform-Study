# vpc 생성
resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    name = "terraform-vpc"
  }
}

# 서브넷 생성
resource "aws_subnet" "terraform-subnet1" {
    vpc_id = aws_vpc.terraform-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-northeast-2a"

    tags = {
      name = "terraform-subnet1"
    }
}

resource "aws_subnet" "terraform-subnet2" {
  vpc_id = aws_vpc.terraform-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    name = "terraform-subnet2"
  }
}

# 인터넷 게이트웨이 생성
resource "aws_internet_gateway" "terraform-igw" {
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    name = "terraform-igw"
  }
}

# 라우팅 테이블 생성
resource "aws_route_table" "terraform-route-table" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-igw.id
  }

  tags = {
    name = "terraform-route-table"
  }
}

# 라우팅 테이블과 서브넷 연결
resource "aws_route_table_association" "subent1-association" {
  subnet_id = aws_subnet.terraform-subnet1.id
  route_table_id = aws_route_table.terraform-route-table.id
}

resource "aws_route_table_association" "subent2-association" {
  subnet_id = aws_subnet.terraform-subnet2.id
  route_table_id = aws_route_table.terraform-route-table.id
}
