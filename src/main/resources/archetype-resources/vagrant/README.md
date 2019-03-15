#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
Vagrant Environment
===================

${symbol_pound}${symbol_pound} Overview

This [Vagrant][vagrant] environment sets up an Ansible Control Host that can be used to deploy the AEM infrastructure to AWS machines or the vagrant box itself.


${symbol_pound}${symbol_pound} Requirements

* Vagrant 2.1.2
  * [vagrant-vbguest plugin](vagrant-vbguest)
* Oracle VM VirtualBox 5.2
* SSH Agent or Putty Pageant


${symbol_pound}${symbol_pound} Setup Vagrant environment

${symbol_pound}${symbol_pound}${symbol_pound} Install required Vagrant
plugins

    vagrant plugin install vagrant-vbguest

${symbol_pound}${symbol_pound}${symbol_pound} Provide vault password

    cd vagrant/shared
    cp .vault_pass.default .vault_pass
    ${symbol_pound} place the Ansible Vault password in .vault_pass

${symbol_pound}${symbol_pound}${symbol_pound} Provide AWS credentials

    cd vagrant/shared
    cp credentials.default credentials
    ${symbol_pound} place your AWS credentials in the credentials file

${symbol_pound}${symbol_pound}${symbol_pound} Check if the project ssh key is provided by your key agent

    ssh-add -L

${symbol_pound}${symbol_pound}${symbol_pound} Start and provision virtual machine

    cd vagrant
    vagrant up

This will do the following things:
* start the specified VM
* sync the project and the configuration management files to the VM
* install ansible
* provision the controlhost via `playbook-setup-controlhost.yml`
  * setup EPEL
  * install nano, iftop, htop, iotop
  * install JDK
  * install Maven
  * configure maven settings
  * setup .bashrc of vagrant user to provide EDITOR and
    ANSIBLE_VAULT_PASSWORD_FILE vault passwords

After provisioning connect to machine and check if project ssh key is
forwarded to the vagrant machine.

    vagrant ssh
    ssh-add -L

The base directory on the VM is:
`/home/vagrant/projects/${configurationManagementName}`


${symbol_pound}${symbol_pound} rsync to vagrant on change

If you want to constanly push changes to the VM run

    vagrant rsync-auto



[vagrant]: https://www.vagrantup.com/
[vagrant-vbguest]: https://github.com/dotless-de/vagrant-vbguest
