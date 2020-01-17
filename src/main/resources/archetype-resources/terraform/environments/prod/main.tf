module "prod-author" {
  centos7_ami_id = var.centos7_ami_id
  vpc_security_group_ids = [var.vpc_security_group_ids]
  instance_profile_name = var.instance_profile_name
  environment = "prod"
  conga_roles = ["aem-cms", "aem-dispatcher"]
  conga_variants = ["aem-author"]
  conga_nodes = ["author.website1.com"]
  instance_name = "author1"
  user_data = var.user_data
  source = "../../modules/nodes/aem"
}

module "prod-publish1" {
  centos7_ami_id = var.centos7_ami_id
  vpc_security_group_ids = [var.vpc_security_group_ids]
  instance_profile_name = var.instance_profile_name
  environment = "prod"
  conga_roles = ["aem-cms", "aem-dispatcher"]
  conga_variants = ["aem-publish"]
  conga_nodes = ["publish1.website1.com"]
  conga_tenants = ["website1.com"]
  instance_name = "publish1"
  user_data = var.user_data
  source = "../../modules/nodes/aem"
}

module "prod-publish2" {
  centos7_ami_id = var.centos7_ami_id
  vpc_security_group_ids = [var.vpc_security_group_ids]
  instance_profile_name = var.instance_profile_name
  environment = "prod"
  conga_roles = ["aem-cms", "aem-dispatcher"]
  conga_variants = ["aem-publish"]
  conga_nodes = ["publish2.website1.com"]
  conga_tenants = ["website1.com"]
  instance_name = "publish2"
  user_data = var.user_data
  source = "../../modules/nodes/aem"
}
