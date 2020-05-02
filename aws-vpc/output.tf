output "main_vpc_arn" {
  value = "${aws_vpc.main.arn}"
  description = "The amazon resource name of the main vpc"
}

# output "publicAsubnetArn" {
#   value = "${aws_vpc.publicAsubnet.arn}"
#   description = "The ARN for publicA subnet"
# }

output "all_public_subnets" {
  value = "$aws_subnet.subnets"
}