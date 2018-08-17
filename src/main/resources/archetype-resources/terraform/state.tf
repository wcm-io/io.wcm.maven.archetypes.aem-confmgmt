terraform {
  backend "s3" {
    bucket = "terraform-state-${configurationManagementName}"
    key    = "${configurationManagementName}-state"
    region = "${awsRegion}"
    dynamodb_table = "terraform-state-locks-${configurationManagementName}"
  }
}