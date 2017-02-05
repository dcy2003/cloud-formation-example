#!/bin/bash

# NOTE: aws-cli and pip are preinstalled on Amazon Linux AMI

# install Git
sudo yum install git -y

# install Ansible
sudo pip install ansible

# Download SSH key from S3
aws s3 cp --region us-east-2 s3://asc-cloudformation-example/cfn-example-key-pair.pem /home/ec2-user/.ssh/ssh-key.pem
chmod 400 /home/ec2-user/.ssh/ssh-key.pem
chown ec2-user:ec2-user /home/ec2-user/.ssh/ssh-key.pem

# Download ~/.ssh/config from S3
aws s3 cp --region us-east-2 s3://asc-cloudformation-example/config /home/ec2-user/.ssh/config
chmod 644 /home/ec2-user/.ssh/config
chown ec2-user:ec2-user /home/ec2-user/.ssh/config

slaveip=10.0.0.11
ssh-keyscan $slaveip 2>/dev/null > slave.keys
cat slave.keys >> /home/ec2-user/.ssh/known_hosts
chmod 644 /home/ec2-user/.ssh/known_hosts
chown ec2-user:ec2-user /home/ec2-user/.ssh/known_hosts
rm slave.keys

# Ansible HOSTS file

# Download Ansible Playbook from Git

# Execute Playbook