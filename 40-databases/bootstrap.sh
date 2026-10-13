#!/bin/bash

set -e

component=$1

environment=$2

dnf install -y git ansible

cd /home/ec2-user

rm -rf ansible-roboshop-roles-tf

git clone https://github.com/Mohanvikasdevops/ansible-roboshop-roles-tf.git

cd ansible-roboshop-roles-tf

git pull

ansible-playbook -e component=${component}  -e environment=$environment roboshop.yaml