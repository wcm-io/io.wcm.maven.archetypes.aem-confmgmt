# Query latest CentOS 7 AMI
data "aws_ami" "centos" {
  most_recent = true
  owners = ["679593333241"]

  filter {
    name   = "owner-alias"
    values = ["aws-marketplace"]
  }

  filter {
    name   = "product-code"
    values = ["aw0evgkw8e5c1q413zgy5pjce"]
  }
}