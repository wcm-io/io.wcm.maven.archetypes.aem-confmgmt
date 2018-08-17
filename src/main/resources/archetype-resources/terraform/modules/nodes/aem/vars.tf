variable "key_name" {
  default = "${configurationManagementName}-key"
}

variable "project" {
  default = "${configurationManagementName}"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "volume_size" {
  default = "20"
}

variable "environment" {
  default = "dev"
}

variable "centos7_ami_id" {
  default = "ami-061b1560"
}

variable "vpc_security_group_ids" {
  default = []
  type = "list"
}

variable "instance_profile_name"{
  default = "${configurationManagementName}-profile"
}

variable "instance_count" {
  default = 1
}

variable "instance_name" {
  default = "aem"
}

variable "conga_roles" {
  default = []
  type= "list"
}

# list of conga_nodes that are running on the instance
variable "conga_nodes" {
  default = []
  type = "list"
}

variable "conga_variants" {
  default = []
  type = "list"
}

variable "conga_tenants" {
  default = []
  type = "list"
}

variable "conga_variant_node_mapping" {
  default = []
  type = "list"
}

variable "user_data" {
  default = "User data"
}
