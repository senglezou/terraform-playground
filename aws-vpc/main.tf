provider "aws" {
  profile = "stella" # never hardcode credentials use profiles instead
  region = "${var.aws_region}"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  # instance_tenancy = "dedicated" - we don't really need dedicated machines.

  tags = {
    Name = "main-vpc"
  }
}

# Create an internet gateway for access to the outside world from the subnets
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

# Create publicA subnet
resource "aws_subnet" "publicA" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
}

# Create publicB subnet
resource "aws_subnet" "publicB" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

# Create publicC subnet
resource "aws_subnet" "publicC" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
}