#!/bin/bash
set -e

HOME_DIR="/home/vagrant"
PROJECTS_DIR="/home/vagrant/projects"
ANSIBLE_VERSION="2.7.13"
ANSIBLE_DIR="$HOME/.ansible"
ANSIBLE_VAULT_PASS_DEST="$ANSIBLE_DIR/.vault_pass"
ANSIBLE_VAULT_PASS_SRC="/vagrant/shared/.vault_pass"
#if( $optionTerraform=="y" )
AWS_CONFIG_DIR="$HOME/.aws"
AWS_CREDENTIALS_SRC="/vagrant/shared/credentials"
AWS_CREDENTIALS_DEST="$AWS_CONFIG_DIR/credentials"
#end

EC='\033[0;31m'
NC='\033[0m' # No Color

# check if required files are present
if [ ! -f "$ANSIBLE_VAULT_PASS_SRC" ]; then
  echo ' ______ _____  _____   ____  _____'
  echo '|  ____|  __ \|  __ \ / __ \|  __ \'
  echo '| |__  | |__) | |__) | |  | | |__) |'
  echo '|  __| |  _  /|  _  /| |  | |  _  / '
  echo '| |____| | \ \| | \ \| |__| | | \ \ '
  echo '|______|_|  \_\_|  \_\\____/|_|  \_\'
  echo -e "${EC}"
  echo "Ansible .vault_pass file not found!"
  echo "Make sure to place/configure the file '.vault_pass' at 'vagrant/shared'."
  echo "See README.md for details."
  echo -e "${NC}"
  exit 1
fi

#if( $optionTerraform=="y" )
if [ ! -f "$AWS_CREDENTIALS_SRC" ]; then
  echo ' ______ _____  _____   ____  _____'
  echo '|  ____|  __ \|  __ \ / __ \|  __ \'
  echo '| |__  | |__) | |__) | |  | | |__) |'
  echo '|  __| |  _  /|  _  /| |  | |  _  / '
  echo '| |____| | \ \| | \ \| |__| | | \ \ '
  echo '|______|_|  \_\_|  \_\\____/|_|  \_\'
  echo -e "${EC}"
  echo "AWS credentials file not found!"
  echo "Make sure to place/configure the file 'credentials' at 'vagrant/shared'."
  echo "See README.md for details."
  echo -e "${NC}"
  exit 2
fi

#end
echo "Provision .vault_pass for Ansible Vault"
# copy vault pass
mkdir -p "$ANSIBLE_DIR"
cp "$ANSIBLE_VAULT_PASS_SRC" "$ANSIBLE_VAULT_PASS_DEST"
chmod 0600 $ANSIBLE_VAULT_PASS_DEST

#if( $optionTerraform=="y" )
# copy aws credentials
echo "Provision AWS credentials"
mkdir -p $AWS_CONFIG_DIR
chmod 0700 $AWS_CONFIG_DIR
cp "$AWS_CREDENTIALS_SRC" "$AWS_CREDENTIALS_DEST"
chmod -R 0600 $AWS_CONFIG_DIR/*

#end
echo "Change ownership on projects dir"
sudo chown -R vagrant:vagrant "$PROJECTS_DIR"

# install git
echo "Install GIT for Ansible Galaxy"
sudo dnf install git -y -q

# install python3 and pip3
echo "Install Python3/pip3"
sudo dnf install -y -q python3 python3-pip

# install ansible
echo "Install Ansible"
sudo -H python3 -m pip install -q --upgrade ansible==$ANSIBLE_VERSION

# update distribution to avoid package conflicts during XMP dependency installation
echo "OS Update"
sudo dnf update -y -q
