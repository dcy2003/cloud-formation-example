Demonstrates the use of CloudFormation to:
* Provision two EC2 instances (as well as a VPC w/IGW, a Subnet, a NACL, a SecurityGroup, etc.)
* Bootstrap one instance with Git and Ansible, download configuration from S3, clone a Git repository, and execute an Ansible playbook against the other instance

Defaults are provided for most parameters with ability to override

## Prerequisites

* AWS account
* [AWS CLI](https://aws.amazon.com/cli/)
* IAM user with sufficient privileges and an access key for this user
* Run `aws configure` to set the desired region, access key, secret access key, etc.
* After cloning this repository, create a key pair in the desired AWS region, download it, and edit `create-stack.sh` to point to it.

## Running

* Run `./create-stack.sh` to provison and configure all resources
* Explore!
* When finished, run `./delete-stack.sh` to tear down all resources
