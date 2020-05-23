provider "aws" {
  profile = "stella" # never hardcode credentials use profiles instead
  region = "${var.aws_region}"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  # instance_tenancy = "dedicated" - we don't really need dedicated machines.

  tags = {
    Name = "main"
  }
}

# Create an internet gateway for access to the outside world from the subnets
resource "aws_internet_gateway" "main_ig" {
  vpc_id = "${aws_vpc.main.id}"

    tags = {
    Name = "mainInternetGateway"
  }
}

# Create all subnets
resource "aws_subnet" "subnets" {
  vpc_id                  = "${aws_vpc.main.id}"
  for_each = "${var.subnet_data}"
  cidr_block = each.value["cidr_block"]

  availability_zone =  each.value["availability_zone"]
  map_public_ip_on_launch = each.value["public_ip_on_launch"]

  tags = {
    Name = each.key
  }
}

# Create public route table, which will be associated to the IG
resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.main.id}"

#  Have the as seperate resource blocks instead of inline. Leaving in for testing 
#  purposes for the moment being
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = "${aws_internet_gateway.main_ig.id}"
#   }

#   route {
#     ipv6_cidr_block        = "::/0"
#     egress_only_gateway_id = "${aws_internet_gateway.main_ig.id}"
#   }

  tags = {
    Name = "public-rt"
  }
}

# Grant the VPC internet access through the publicRT
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_route_table.public_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main_ig.id}"
}

# Grant the VPC internet access through the publicRT using ipv6
resource "aws_route" "internet_access_ipv6" {
  route_table_id         = "${aws_route_table.public_route_table.id}"
  destination_cidr_block = "::/0" # might need to be just destination_cidr_block
  gateway_id             = "${aws_internet_gateway.main_ig.id}"
}

# Associate only the public subnets with the public route table
resource "aws_route_table_association" "public_rt_assoc" {
  for_each = {
      for key, value in "${var.subnet_data}": key => value
      if value["associate_subnet_to_route_table"] == public
  }
  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_eip" "eips" {
    for_each = {
      for key, value in "${var.subnet_data}": key => value
      if value["associate_subnet_to_route_table"] == public
  }
  vpc = true
  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_nat_gateway" "nat_gw" {
    for_each = {
      for key, value in "${var.subnet_data}": key => value
      if value["associate_subnet_to_route_table"] == public
  }

  allocation_id = "${aws_eip.id}"
  subnet_id = "${aws_subnet.subnets[each.key].id}"

  depends_on = ["aws_internet_gateway.gw"]
  tags = {
    Name = "mainVPC_nat_gw"
  }
}


# Create private route table, which will be associated to the IG
resource "aws_route_table" "private_route_tables" {
  for_each = {
      for key, value in "${var.subnet_data}": key => value
      if value["associate_subnet_to_route_table"] == private
  }
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = value["rt_name_assoc"]
  }
}

# Associate only the public subnets with the route table
resource "aws_route_table_association" "private_rt_assoc" {
  for_each = {
      for key, value in "${var.subnet_data}": key => value
      if value["associate_subnet_to_route_table"] == private || value["associate_subnet_to_route_table"] == internal
  }
  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = aws_route_table.public_route_table[value["rt_name_assoc"]].id
}


# Create a bastion instance. It does not be bigger than t3.micro.
# -SG
# Create a security group for the bastion instance
resource "aws_security_group" "bastion_sg"{
    name = "bastionSG"
    description = "SG for the bastion instance"
    vpc_id = "${aws_vpc.main.id}"

    # allow all outbound traffic
   egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
   }
   # SSH access from anywhere. It's just a bastion afterall!
   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    Name = "bastionSG"
  }

}

# Create a bastion instance to
resource "aws_instance" "bastion" {
    instance_type = "t3.micro"
    ami           = "${var.aws_amis["${var.aws_region}"]}"
    subnet_id = "${aws_subnet.subnets["publicBsubnet"].id}"
    associate_public_ip_address = true
    vpc_security_group_ids = [
      "${aws_security_group.bastion_sg.id}",
    ]
    key_name   = "stos_stella_key"

    tags = {
    Name = "BastionHost"
    Environment = "staging"
    }
  
}

