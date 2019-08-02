# nodes/network.tf

provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = "true"

  tags = {
    Name = "test_vpc"
  }
}

resource "aws_internet_gateway" "test_vpc_igw" {
  # depends_on = ["aws_vpc.test_vpc"]

  vpc_id = "${aws_vpc.test_vpc.id}"

  tags = {
    Name = "test_vpc_igw"
  }
}

resource "aws_route_table" "test_vpc_public_rt" {
  # depends_on = ["aws_internet_gateway.test_vpc_igw", "aws_subnet.test_subnet"]

  vpc_id = "${aws_vpc.test_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.test_vpc_igw.id}"
  }

  tags = {
    Name = "test_vpc_public_rt"
  }
}

resource "aws_default_route_table" "test_vpc_private_rt" {
  depends_on = ["aws_internet_gateway.test_vpc_igw"]

  default_route_table_id = "${aws_vpc.test_vpc.default_route_table_id}"

  tags = {
    name = "test_vpc_private_rt"
  }
}



resource "aws_subnet" "test_subnet" {
  # depends_on = ["aws_vpc.test_vpc"]
  vpc_id     = "${aws_vpc.test_vpc.id}"
  cidr_block = "10.0.0.0/16"

  availability_zone = "us-west-2a"

  tags = {
    Name = "test_subnet"
  }
}

resource "aws_route_table_association" "test_public_assoc" {
  depends_on     = ["aws_internet_gateway.test_vpc_igw", "aws_security_group.test_vpn_sg"]
  subnet_id      = "${aws_subnet.test_subnet.id}"
  route_table_id = "${aws_route_table.test_vpc_public_rt.id}"
}

resource "aws_security_group" "test_vpn_sg" {
  # depends_on  = ["aws_vpc.test_vpc"]
  name        = "test_public_sg"
  description = "test node network security group"
  vpc_id      = "${aws_vpc.test_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.access_ip}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}









