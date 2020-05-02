variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "eu-west-1" # ireland
}

variable "aws_amis" {
  default = {
    eu-west-1 = ""
    eu-west-2 = ""
  }
}