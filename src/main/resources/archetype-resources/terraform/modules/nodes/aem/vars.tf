#if ($awsMachineSize == "large")
  #set( $prodInstanceType = "t2.2xlarge" )
#elseif ($awsMachineSize == "medium")
  #set( $prodInstanceType = "t2.xlarge" )
#else
  #set( $prodInstanceType = "t2.medium" )
#end
variable "key_name" {
  default = "${configurationManagementName}-key"
}

variable "project" {
  default = "${configurationManagementName}"
}

variable "instance_type" {
  default = "${prodInstanceType}"
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
  type = list(string)
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
  type = list(string)
}

# list of conga_nodes that are running on the instance
variable "conga_nodes" {
  default = []
  type = list(string)
}

variable "conga_variants" {
  default = []
  type = list(string)
}

variable "conga_tenants" {
  default = []
  type = list(string)
}

variable "conga_variant_node_mapping" {
  default = []
  type = list(string)
}

variable "user_data" {
  default = "User data"
}
