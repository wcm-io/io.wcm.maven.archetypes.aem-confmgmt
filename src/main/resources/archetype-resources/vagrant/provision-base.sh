#!/bin/bash
set -e

HOME_DIR="/home/vagrant"
PROJECT_DIR="/home/vagrant/projects/${configurationManagementName}"
ANSIBLE_DIR="$HOME/.ansible"
ANSIBLE_VAULT_PASS_DEST="$ANSIBLE_DIR/.vault_pass"
ANSIBLE_VAULT_PASS_SRC="/vagrant/shared/.vault_pass"
AWS_CONFIG_DIR="$HOME/.aws"
AWS_CREDENTIALS_SRC="/vagrant/shared/credentials"
AWS_CREDENTIALS_DEST="$AWS_CONFIG_DIR/credentials"

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
 echo "Make sure to place/configure the file '.vault_pass' below 'vagrant/shared'"
 echo -e "${NC}"
 exit 1
fi

if [ ! -f "$AWS_CREDENTIALS_SRC" ]; then
  echo ' ______ _____  _____   ____  _____'
  echo '|  ____|  __ \|  __ \ / __ \|  __ \'
  echo '| |__  | |__) | |__) | |  | | |__) |'
  echo '|  __| |  _  /|  _  /| |  | |  _  / '
  echo '| |____| | \ \| | \ \| |__| | | \ \ '
  echo '|______|_|  \_\_|  \_\\____/|_|  \_\'
  echo -e "${EC}"
  echo "AWS credentials file not found!"
  echo "Make sure to place/configure the file 'credentials' below 'vagrant/shared'"
  echo -e "${NC}"
  exit 2
fi

echo "Provision .vault_pass for Ansible Vault"
# copy vault pass
cp "$ANSIBLE_VAULT_PASS_SRC" "$ANSIBLE_VAULT_PASS_DEST"
chmod 0600 $ANSIBLE_VAULT_PASS_DEST

# copy aws credentials
echo "Provision AWS credentials"
mkdir -p $AWS_CONFIG_DIR
chmod 0700 $AWS_CONFIG_DIR
cp "$AWS_CREDENTIALS_SRC" "$AWS_CREDENTIALS_DEST"
chmod -R 0600 $AWS_CONFIG_DIR/*

# install git
echo "Install GIT for Ansible Galaxy"
sudo yum install git -y -q
