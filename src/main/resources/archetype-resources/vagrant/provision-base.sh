#!/bin/bash
set -e
set -x

HOME_DIR="/home/vagrant"
PROJECT_DIR="/home/vagrant/projects/${configurationManagementName}"
ANSIBLE_DIR="$HOME/.ansible"
AWS_CONFIG_DIR="$HOME/.aws"

ANSIBLE_VAULT_PASS_PATH="$ANSIBLE_DIR/.vault_pass"

# copy vault pass
cp /vagrant/shared/.vault_pass "$ANSIBLE_VAULT_PASS_PATH"
chmod 0600 $ANSIBLE_VAULT_PASS_PATH

# copy aws credentials
mkdir -p $AWS_CONFIG_DIR
chmod 0700 $AWS_CONFIG_DIR
cp /vagrant/shared/credentials "$AWS_CONFIG_DIR/"
chmod -R 0600 $AWS_CONFIG_DIR/*

# install git
sudo yum install git -y -q
