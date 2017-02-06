#!/bin/bash

# install git and jq
sudo yum install git jq -y

# install ansible
sudo pip install ansible

# Variable Declarations
region=us-east-2
s3_bucket=s3://asc-cloudformation-example
key_pair=cfn-example-key-pair.pem
git_repo=git@github.com:dcy2003/cloud-formation-example.git
temp_dir=/usr/tmp
playbook_path=cloud-formation-example/ansible-playbook.yaml
ssh_user=ec2-user
slave_node_ssh_key=/home/$ssh_user/.ssh/ssh-key.pem
ssh_config=/home/$ssh_user/.ssh/config
ssh_known_hosts=/home/ec2-user/.ssh/known_hosts

# NOTE: aws-cli and pip are preinstalled on Amazon Linux AMI

# Download SSH key from S3
aws s3 cp --region $region $s3_bucket/$key_pair $slave_node_ssh_key
chmod 400 $slave_node_ssh_key
chown $ssh_user:$ssh_user $slave_node_ssh_key

# FIXME: dynamically generate slave entries
# Download ~/.ssh/config from S3
aws s3 cp --region $region $s3_bucket/config $ssh_config
chmod 644 $ssh_config
chown $ssh_user:$ssh_user $ssh_config

# Add slave nodes to known_hosts and ansible/hosts files
mkdir /etc/ansible
touch /etc/ansible/hosts

echo "[slaves]" >> /etc/ansible/hosts

slaveips=`aws ec2 describe-instances --region $region --filters "Name=tag:Name,Values=SlaveNode" | jq -r '.Reservations[].Instances[].NetworkInterfaces[] | .PrivateIpAddress'`
for slaveip in $slaveips
do
  echo "$slaveip"
  ssh-keyscan -H $slaveip >> $ssh_known_hosts
  echo "$slaveip ansible_user=$ssh_user ansible_connection=ssh ansible_ssh_private_key_file=$slave_node_ssh_key" >> /etc/ansible/hosts
done

chmod 644 $ssh_known_hosts
chown $ssh_user:$ssh_user $ssh_known_hosts

chmod 644 /etc/ansible/hosts
chown $ssh_user:$ssh_user /etc/ansible/hosts

# Add GitHub and it IPs to root users known_hosts
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
for github_ip in `dig +short github.com`
do
  ssh-keyscan -H $github_ip >> ~/.ssh/known_hosts
done
cat $ssh_known_hosts >> ~/.ssh/known_hosts

# Download Ansible Playbook from Git
cp $ssh_config ~/.ssh/config
chown root:root ~/.ssh/config
cd $temp_dir
git clone $git_repo

# Execute Playbook
# Specifying full path for ansible-playbook since it is not found in the path for the duration of userdata script
/usr/local/bin/ansible-playbook $temp_dir/$playbook_path
