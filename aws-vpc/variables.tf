variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "eu-west-1" # ireland
}

# TODO
variable "aws_amis" {
  type = map
  default = {
    eu-west-1 = "ami-06ce3edf0cff21f07"
    eu-west-2 = "ami-01a6e31ac994bbc09"
  }
}

# Great explanation on how to use structural types found here:
# https://www.intrepidintegration.com/tech/how-to-reference-data-objects-with-terraform/
variable "subnet_data" {
  type = map(object({
    cidr_block    = string
    availability_zone = string
    public_ip_on_launch = bool
    associate_subnet_to_route_table = string
    rt_name_assoc = string
    nat_association = string
  }))
    default = { subnet = {
        cidr_block = "10.0.10.0/24"
        availability_zone = "eu-west-1c"
        public_ip_on_launch = false
        associate_subnet_to_route_table = "private"
        rt_name_assoc = "privateA-rt"
        nat_association = "public-rt"
    }
    }
}