variable "centos7_ami_id" {
  default = "ami-061b1560"
}

variable "vpc_security_group_ids" {
  default = []
  type = list(string)
}

variable "instance_profile_name" {
  default = "${configurationManagementName}-profile"
}

variable "user_data" {
  default = "User data"
}
