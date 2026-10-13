#!/bin/bash

set -e

component=$1

dnf install -y git ansible

cd /home/ec2-user

rm -rf ansible-roboshop-roles-tf

git clone https://github.com/Mohanvikasdevops/ansible-roboshop-roles-tf.git

cd ansible-roboshop-roles-tf

ansible-playbook -e component=${component} roboshop.yaml