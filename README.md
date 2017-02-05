# EC2 Bootstrap Example 

**Uses CloudFormation, cloud-init, and Ansible to provision and bootstrap two EC2 instances**

Example bootstrap script demonstrates how to:

* Install Ansible
* Download resources from S3 to configure SSH to other instance
* Clone a Git repository
* Execute an Ansible playbook to configure the other instance

## Prerequisites:

* AWS account
* [AWS CLI](https://aws.amazon.com/cli/)
* IAM user with sufficient privileges + access key
* Run `aws configure` to set the desired region, access key, secret access key
* A key pair in the desired AWS region

## To Run:

* Edit `create-stack.sh` as necessary:
 * ensure you pass the correct value for `EC2SshKey`
 * see `cfn-template.json` for complete list of parameters
* Run `./create-stack.sh` to provison and configure all resources.

## Take Note Of:

* point
* out
* things

## Cleanup:

* When finished, run `./delete-stack.sh` to tear down all resources.
