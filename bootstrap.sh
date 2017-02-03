#!/bin/bash

# NOTE: aws-cli and pip are preinstalled on Amazon Linux AMI

# install Git
sudo yum install git -y

# install Ansible
sudo pip install ansible

# Download Git deployment key from S3

# Download ~/.ssh/config from S3

# Download Ansible HOSTS file from S3

# Download Ansible Playbook from S3

# Execute Playbook