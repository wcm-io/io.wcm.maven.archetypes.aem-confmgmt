#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

echo '####################'
echo 'provision-as-root.sh'
echo '####################'

echo 'apt update...'
apt-get -qq update > /dev/null

echo 'install OS packages...'
apt-get install git -qq > /dev/null

echo 'apt upgrade...'
apt-get -qq upgrade > /dev/null
