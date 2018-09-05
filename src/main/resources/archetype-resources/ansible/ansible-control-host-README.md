#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
Ansible Control Host
====================

Requirements:

* Ansible 2.4.6+
#if( $optionTerraform=="y" )
* Terraform 0.11.7+
#end

Setup steps:

* Load SSH key accessing the AWS machines in your SSH agent or Putty Pageant
* Run Ansible playbook `playbook-setup-controlhost.yml`
* Provide vault password
* Provide AWS credentials


${symbol_pound}${symbol_pound} Basic setup

All commands must be executed within the `ansible` folder.

${symbol_pound}${symbol_pound}${symbol_pound} Ansible vault password

Place a file `.vault_pass` in the `ansible` directory and insert the
ansible vault password there.

${symbol_pound}${symbol_pound}${symbol_pound} Install roles

    ansible-playbook playbook-install-roles.yml

#if( $optionTerraform=="y" )
${symbol_pound}${symbol_pound} AWS Credentials

Provide the AWS Credentials either by setting up environment variables
as described
[here](https://www.terraform.io/docs/providers/aws/index.html), or by
setting up a credentials file as described [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html)
#end
