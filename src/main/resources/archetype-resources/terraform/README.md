#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
Terraform Definition
====================

${symbol_pound}${symbol_pound} Overview

This project used [HashiCorp Terraform][terraform] to describe the required infrastructure for the AEM environments and set it up in AWS.

The definitions contains the machines for DEV and PROD environment.


${symbol_pound}${symbol_pound} Setup

${symbol_pound}${symbol_pound}${symbol_pound} Initialize state bucket and lock db

```bash
cd terraform/terraform-state
terraform init
terraform plan -out state
${symbol_pound} inspect the plan for unwanted changes!
terraform apply state
```

${symbol_pound}${symbol_pound}${symbol_pound} Setup AWS infrastructure

```bash
cd terraform
terraform init
terraform plan -out infrastructure
${symbol_pound} inspect the plan for unwanted changes!
terraform apply infrastructure
```

${symbol_pound}${symbol_pound}${symbol_pound} Get a fresh inventory (optional, just in case)

```bash
cd ansible    
./inventory/ec2.py --refresh-cache
```


${symbol_pound}${symbol_pound} Teardown

${symbol_pound}${symbol_pound}${symbol_pound} Teardown AWS infrastructure

```bash
cd terraform
terraform destroy
${symbol_pound} type in "yes" when you are asked
```

${symbol_pound}${symbol_pound}${symbol_pound} Teardown state bucket and lock db

${symbol_pound}${symbol_pound}${symbol_pound}${symbol_pound} Empty and delete the state bucket

Go to the AWS S3 Console, select the bucket and click on "Empty Bucket".
Then delete the bucket.

${symbol_pound}${symbol_pound}${symbol_pound}${symbol_pound} Destroy the lock db table

Go to the AWS DynamoDB Console and delete the corresponding table.



[terraform]: https://www.terraform.io/
