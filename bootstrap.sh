#!/bin/bash

# NOTE: aws-cli and pip are preinstalled on Amazon Linux AMI

# install Git
sudo yum install git jq -y

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

# Add slave nodes to known_hosts and ansible/hosts files
mkdir /etc/ansible
touch /etc/ansible/hosts

echo "[slaves]" >> /etc/ansible/hosts

# FIXME parameterize region
slaveips=`aws ec2 describe-instances --region us-east-2 --filters "Name=tag:Name,Values=SlaveNode" | jq -r '.Reservations[].Instances[].NetworkInterfaces[] | .PrivateIpAddress'`

for slaveip in $slaveips
do
  echo "$slaveip"
  ssh-keyscan -H $slaveip >> /home/ec2-user/.ssh/known_hosts
  echo "$slaveip ansible_user=ec2-user ansible_connection=ssh ansible_ssh_private_key_file=/home/ec2-user/.ssh/ssh-key.pem" >> /etc/ansible/hosts
done

chmod 644 /home/ec2-user/.ssh/known_hosts
chown ec2-user:ec2-user /home/ec2-user/.ssh/known_hosts

chmod 644 /etc/ansible/hosts
chown ec2-user:ec2-user /etc/ansible/hosts

# Add GitHub and it IPs to root users known_hosts
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
for github_ip in `dig +short github.com`
do
  ssh-keyscan -H $github_ip >> ~/.ssh/known_hosts
done
cat /home/ec2-user/.ssh/known_hosts >> ~/.ssh/known_hosts

# Download Ansible Playbook from Git
cp /home/ec2-user/.ssh/config ~/.ssh/config
chown root:root ~/.ssh/config
cd /usr/tmp
git clone git@github.com:dcy2003/cloud-formation-example.git

# Execute Playbook
# Specifying full path for ansible-playbook since it is not found in the path for the duration of userdata script for some reason
/usr/local/bin/ansible-playbook /usr/tmp/cloud-formation-example/ansible-playbook.yaml
