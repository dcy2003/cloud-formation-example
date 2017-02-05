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

# Add slave node to known_hosts
slaveip=10.0.0.11
ssh-keyscan $slaveip 2>/dev/null > slave.keys
cat slave.keys >> /home/ec2-user/.ssh/known_hosts
chmod 644 /home/ec2-user/.ssh/known_hosts
chown ec2-user:ec2-user /home/ec2-user/.ssh/known_hosts
rm slave.keys

# Generate Ansible HOSTS file
mkdir /etc/ansible
touch /etc/ansible/hosts
echo "[slaves]" >> /etc/ansible/hosts
echo "10.0.0.11 ansible_user=ec2-user ansible_connection=ssh ansible_ssh_private_key_file=/home/ec2-user/.ssh/ssh-key.pem" >> /etc/ansible/hosts
chmod 644 /etc/ansible/hosts
chown ec2-user:ec2-user /etc/ansible/hosts

# Download Ansible Playbook from Git

# Execute Playbook