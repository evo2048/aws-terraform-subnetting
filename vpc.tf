resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "ECS-IGW"
  }
}
resource "aws_vpc" "vpc" {
    cidr_block = "192.168.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "ECS-VPC"
    }
}
resource "aws_subnet" "public-subnet1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "192.168.0.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"
    tags = {
        Name = "Public subnet US-EAST-1A"
    }
}
resource "aws_subnet" "private-subnet1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "192.168.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false
    tags = {
      Name = "Private subnet US-EAST-1A"
    }
}
resource "aws_subnet" "public-subnet2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "192.168.2.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1b"
    tags = {
      Name = "Public subnet US-EAST-1B"
    }
}
resource "aws_subnet" "private-subnet2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "192.168.3.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private subnet US-EAST-1B"
  }
}
resource "aws_route_table" "routing" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet-gateway.id
    }
    depends_on = [
      aws_internet_gateway.internet-gateway
    ]
    tags = {
      Name = "Public subnets IGW"
    }
}
resource "aws_route_table_association" "route-sb-1A" {
    subnet_id = aws_subnet.public-subnet1.id
    route_table_id = aws_route_table.routing.id
}
resource "aws_route_table_association" "route-sb-1B" {
    subnet_id = aws_subnet.public-subnet2.id
    route_table_id = aws_route_table.routing.id
}