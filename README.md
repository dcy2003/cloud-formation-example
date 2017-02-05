**Demonstrates the use of CloudFormation to provision and bootstrap two EC2 instances** with supporting IAM instance role, VPC, Subnet, NACL, Security Group, etc.

One of the EC2 instances is passed a bootstrap script that demonstrates how to:
* install Ansible
* download resources from S3 to configure SSH to other instance
* clone a Git repository
* execute an Ansible playbook to configure the other instance

Defaults are provided for most parameters with ability to override

## Prerequisites

* AWS account
* [AWS CLI](https://aws.amazon.com/cli/)
* IAM user with sufficient privileges + access key
* Run `aws configure` to set the desired region, access key, secret access key
* A key pair in the desired AWS region

## To Run

* Edit `create-stack.sh` as necessary
** Ensure you pass the correct value for `EC2SshKey`
* Run `./create-stack.sh` to provison and configure all resources

## Take Note Of:

* point
* out
* things

## To Cleanup

* When finished, run `./delete-stack.sh` to tear down all resources
