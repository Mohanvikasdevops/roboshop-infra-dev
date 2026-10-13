#!/bin/bash

# Extend disk from 20G to 50G
growpart /dev/nvme0n1 4
pvresize /dev/nvme0n1p4
lvextend -r -l +100%FREE /dev/mapper/RootVG-homeVol

# Install Terraform
dnf install -y dnf-plugins-core
dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
dnf install -y terraform

terraform --version > /tmp/terraform-version.txt