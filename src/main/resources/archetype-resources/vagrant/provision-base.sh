#!/bin/bash
set -e

HOME_DIR="/home/vagrant"
PROJECTS_DIR="/home/vagrant/projects"
#if( $optionTerraform=="y" )
AWS_CONFIG_DIR="$HOME/.aws"
AWS_CREDENTIALS_SRC="/vagrant/shared/credentials"
AWS_CREDENTIALS_DEST="$AWS_CONFIG_DIR/credentials"
#end

EC='\033[0;31m'
NC='\033[0m' # No Color

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
sudo yum install git -y -q

# install pip
if ! [ -x "$(command -v pip)" ]; then
  echo 'pip is not installed, installing' >&2
  sudo curl -s https://bootstrap.pypa.io/get-pip.py | sudo python 2>&1
else
  echo 'pip is already installed'
fi

# update distribution to avoid package conflicts during XMP dependency installation
echo "OS Update"
sudo yum update -y
