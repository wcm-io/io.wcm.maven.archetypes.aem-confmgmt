#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
Ansible Playbooks
=================

${symbol_pound}${symbol_pound} Overview

The [Ansible Playbooks][ansible-playbooks] describe the deployment tasks to provision and deploy the AEM infrastructure. The files in this folder contain only the entry points and project-specific configuration, the main logic comes from the [wcm.io DevOps Ansible roles][ansible-galaxy-wcm-io-devops].


${symbol_pound}${symbol_pound} Requirements

The playbooks have to be executed on the Ansible Control Host. You have two alternatives for setting it up:

* Setting up a preconfigured [Vagrant Environment][vagrant-folder]
* Setting up an existing machine as [Ansible Control Host][ansible-folder-ansible-control-host]


${symbol_pound}${symbol_pound} Execute playbooks

${symbol_pound}${symbol_pound}${symbol_pound} Setup DEV environment

    ansible-playbook playbook-setup-dev.yml


${symbol_pound}${symbol_pound}${symbol_pound} Setup PROD environment

    ansible-playbook playbook-setup-prod.yml


${symbol_pound}${symbol_pound}${symbol_pound} Setup LOCAL environment (e.g. in Vagrant box)

    ansible-playbook playbook-setup-local.yml -i inventory/local



[ansible-folder-ansible-control-host]: ansible-control-host-README.md
[vagrant-folder]: vagrant
[ansible-playbooks]: https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html
[ansible-galaxy-wcm-io-devops]: https://galaxy.ansible.com/wcm_io_devops
