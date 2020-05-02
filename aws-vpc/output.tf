output "mainvpcarn" {
  value = "${aws_vpc.main.arn}"
  description = "The amazon resource name of the main vpc"
}
