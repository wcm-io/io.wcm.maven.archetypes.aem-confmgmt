#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
${configurationManagementName} Configuration Management
=======================================

${symbol_pound}${symbol_pound} Overview

This is a "configuration management" project for deploying the AEM application "${projectName}" to AEM infrastructure using [CONGA][conga] and the [wcm.io DevOps Ansible Integration][wcmio-devops-ansible]. It consists of the following parts:

* [CONGA configuration][configuration-folder]: defines the environments and AEM configuration and artifacts to deploy
* [Terraform Definition][terraform-folder]: defines the AWS infrastructure to deploy to
* [Ansible Playbooks][ansible-folder]: Ansible playbooks used to provision and deploy the AEM infrastructure
* [Vagrant Environment][vagrant-folder]: Local vagrant environment that can be used as local Ansible control host and deployment target


${symbol_pound}${symbol_pound} Prepare Maven Repository

The AEM application with this CONGA configuration definitions is deployed (the artifacts are expected to be found in the Maven Repository):

* Group ID: `${groupId}`
* Artifact ID: `${artifactId}.config-definition`

Additionally Adobe AEM binaries need to be deployed to the Maven Repository. These are not available in the public Adobe or Maven Central repositories, you need to deploy them into your own Maven Repository following [these naming conventions][aem-binaries-conventions]. You need to deploy the following artifacts:

* AEM Quickstart JAR
* Any AEM Service Pack/Feature Pack/Hotfix that is references in your project's configuration definition
* AEM Dispatcher binary files for your environment


${symbol_pound}${symbol_pound} Setup AEM infrastructure

${symbol_pound}${symbol_pound}${symbol_pound} 1. Prepare Ansible control host

The Ansible control host runs the Ansible playbooks and connects to the target machines via SSH. The Ansible playbooks make use of Maven and the CONGA Maven plugin to generate and deploy the application and configuration artifacts, thus the control hosts needs to haven Maven installed as well and a Maven Repository configured to load the project's artifacts and AEM binaries.

${symbol_pound}${symbol_pound}${symbol_pound}${symbol_pound} Use Vagrant as control host

* Setup the [Vagrant Environment][vagrant-folder]
* Connect to the Vagrant box via SSH for the further steps
* Make sure the SSH key for accessing the AWS machines is available in the Vagrant box by either using agent agent forwarding or loading it in the vagrant box SSH agent


${symbol_pound}${symbol_pound}${symbol_pound}${symbol_pound} Use existing machine as control host

* Setup the machine as [Ansible Control Host][ansible-folder-ansible-control-host]
* Load SSH key accessing the AWS machines in your SSH agent or Putty Pageant


${symbol_pound}${symbol_pound}${symbol_pound} 2. Setup AWS infrastructure using Terraform

* Execute the setup steps from [Terraform Definition][terraform-folder-setup] on the Ansible control host


${symbol_pound}${symbol_pound}${symbol_pound} 3. Run Ansible playbooks for deployment

* Execute the [Ansible Playbooks][ansible-folder-execute-playbooks] on the Ansible control host to setup and deploy the different environments


${symbol_pound}${symbol_pound}${symbol_pound} 4. Access your infrastructure

${symbol_pound}${symbol_pound}${symbol_pound}${symbol_pound} Hostfile

You need to add to your hostfile:

    ${symbol_pound} DEV environment
    [dev-ip] dev.website1.com author-dev.website1.com
    ${symbol_pound} PROD environment
    [prod-publish1-ip] publish1.website1.com website1.com
    [prod-publish2-ip] publish2.website1.com website1.com
    [prod-author-ip] author.website1.com    
    ${symbol_pound} LOCAL environment
    127.0.0.1 local-website1
    127.0.0.1 author.local-website1 

:bulb: The playbooks `playbook-setup-prod.yml` and
`playbook-setup-dev.yml` will place host files for the environment below
`ansible/files/tmp` for your convenience.


${symbol_pound}${symbol_pound}${symbol_pound}${symbol_pound} Author/Publish URLs

DEV environment:

* Publish: http://dev.website1.com
* Author: https://author-dev.website1.com

PROD environment:

* Publish 1: http://publish1.website1.com
* Publish 2: http://publish2.website1.com
* Author: https://author.website1.com

LOCAL environment (via Vagrant box):

* Publish: http://local-website1:8080
* Author: https://author.local-website1:8443


${symbol_pound}${symbol_pound} Teardown AEM infrastructure

${symbol_pound}${symbol_pound}${symbol_pound} Teardown AWS Infrastructure using Terraform

* Execute the teardown steps from [Terraform Definition][terraform-folder-teardown] on the Ansible control host



[ansible-folder]: ansible
[ansible-folder-ansible-control-host]: ansible/ansible-control-host-README.md
[ansible-folder-execute-playbooks]: ansible${symbol_pound}execute-playbooks
[configuration-folder]: configuration
[terraform-folder]: terraform
[terraform-folder-setup]: terraform${symbol_pound}setup
[terraform-folder-teardown]: terraform${symbol_pound}teardown
[vagrant-folder]: vagrant

[conga]: http://devops.wcm.io/conga/
[wcmio-devops-ansible]: http://devops.wcm.io/ansible.html
[aem-binaries-conventions]: https://wcm-io.atlassian.net/wiki/x/AYC9Aw
