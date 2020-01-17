provider "aws" {
  region = "${awsRegion}"
}

resource "aws_dynamodb_table" "terraform_statelock" {
  name           = "terraform-state-locks-${configurationManagementName}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "terraform_statelock" {
  bucket = "terraform-state-${configurationManagementName}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Project = "${configurationManagementName}"
  }
}
