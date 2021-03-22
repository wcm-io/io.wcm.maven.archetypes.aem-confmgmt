#!/bin/bash
set -e

HOME_DIR="/home/vagrant"
PROJECTS_DIR="/home/vagrant/projects"
ANSIBLE_VAULT_PASS_SRC="/vagrant/shared/.vault_pass"
ANSIBLE_VAULT_PASS_DEST="/home/vagrant/.ansible/.vault_pass"
#if( $optionTerraform=="y" )
AWS_CONFIG_DIR="$HOME/.aws"
AWS_CREDENTIALS_SRC="/vagrant/shared/credentials"
AWS_CREDENTIALS_DEST="$AWS_CONFIG_DIR/credentials"
#end

EC='\033[0;31m'
NC='\033[0m' # No Color

if [ ! -f "$ANSIBLE_VAULT_PASS_SRC" -a ! -f "$ANSIBLE_VAULT_PASS_DEST" ]; then
  echo ' ______ _____  _____   ____  _____'
  echo '|  ____|  __ \|  __ \ / __ \|  __ \'
  echo '| |__  | |__) | |__) | |  | | |__) |'
  echo '|  __| |  _  /|  _  /| |  | |  _  / '
  echo '| |____| | \ \| | \ \| |__| | | \ \ '
  echo '|______|_|  \_\_|  \_\\____/|_|  \_\'
  echo -e "${EC}"
  echo "Ansible .vault_pass file not found!"
  echo "Make sure to place/configure the file '.vault_pass' at 'vagrant/shared' or to enter the password on provisioning."
  echo "See README.md for details."
  echo -e "${NC}"
  exit 1
fi

if [ ! -f "$ANSIBLE_VAULT_PASS_DEST" ]; then
  echo "Provision .vault_pass for Ansible Vault"
  mkdir -p `dirname $ANSIBLE_VAULT_PASS_DEST`
  cp "$ANSIBLE_VAULT_PASS_SRC" "$ANSIBLE_VAULT_PASS_DEST"
fi

chmod 0600 $ANSIBLE_VAULT_PASS_DEST

if [ -f "$ANSIBLE_VAULT_PASS_SRC" ]; then
  echo "Deleting Ansible Vault password file from host"
  rm "$ANSIBLE_VAULT_PASS_SRC"
fi

#if( $optionTerraform=="y" )
if [ ! -f "$AWS_CREDENTIALS_SRC" -a ! -f "$AWS_CREDENTIALS_DEST" ]; then
  echo ' ______ _____  _____   ____  _____'
  echo '|  ____|  __ \|  __ \ / __ \|  __ \'
  echo '| |__  | |__) | |__) | |  | | |__) |'
  echo '|  __| |  _  /|  _  /| |  | |  _  / '
  echo '| |____| | \ \| | \ \| |__| | | \ \ '
  echo '|______|_|  \_\_|  \_\\____/|_|  \_\'
  echo -e "${EC}"
  echo "AWS credentials file not found!"
  echo "Make sure to place/configure the file 'credentials' at 'vagrant/shared' or to enter the credentials on provisioning."
  echo "See README.md for details."
  echo -e "${NC}"
  exit 2
fi

if [ ! -f "$AWS_CREDENTIALS_DEST" ]; then
  echo "Provision AWS credentials"
  mkdir -p $AWS_CONFIG_DIR
  cp "$AWS_CREDENTIALS_SRC" "$AWS_CREDENTIALS_DEST"
fi

chmod 0700 $AWS_CONFIG_DIR
chmod -R 0600 $AWS_CONFIG_DIR/*

if [ -f "$AWS_CREDENTIALS_SRC" ]; then
  echo "Deleting AWS credentials file from host"
  rm "$AWS_CREDENTIALS_SRC"
fi

#end
echo "Change ownership on projects dir"
sudo chown -R vagrant:vagrant "$PROJECTS_DIR"

# place file in shared folder to signalize vagrant that provision was performed successfully
echo "creating .provision_done file"
touch /vagrant/shared/.provision_done
