variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "eu-west-1" # ireland
}

# TODO
variable "aws_amis" {
  default = {
    eu-west-1 = ""
    eu-west-2 = ""
  }
}

# Great explanation on how to use structural types found here:
# https://www.intrepidintegration.com/tech/how-to-reference-data-objects-with-terraform/
variable "subnet_data" {
  type = map(object({
    cidr_block    = string
    availability_zone = string
  }))
    default = { subnet = {
        cidr_block = "10.0.10.0/24"
        availability_zone = "eu-west-1c" # todo: make dynamic
    }
    }

}