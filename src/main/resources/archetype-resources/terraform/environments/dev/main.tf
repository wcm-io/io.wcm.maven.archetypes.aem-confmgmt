module "aem" {
  centos7_ami_id = var.centos7_ami_id
  vpc_security_group_ids = ["var.vpc_security_group_ids"]
  instance_profile_name = var.instance_profile_name
  environment = "dev"
#if ($awsMachineSize == "small")
  instance_type = "t2.large"
#end
  conga_roles = ["aem-cms,aem-dispatcher"]
  conga_variants = ["aem-author","aem-publish"]
  conga_nodes = ["author-dev.website1.com","dev.website1.com"]
  conga_variant_node_mapping = [
    "aem-author=author-dev.website1.com",
    "aem-publish=dev.website1.com",
  ]
  user_data = var.user_data
  source = "../../modules/nodes/aem"
}
