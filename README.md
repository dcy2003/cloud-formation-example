## Prerequisites

* An AWS account
* The [AWS CLI](https://aws.amazon.com/cli/)
* An IAM user with sufficient privileges and an access key for this user
* Run `aws configure` to set the desired region, access key, secret access key, etc.
* After cloning the repository, create a key pair in the desired AWS region, download it, and edit `create-stack.sh` to point to it.

## Running

* Run `./create-stack.sh` to provison and configure all resources
* Explore!
* When finished, run `./delete-stack.sh` to tear down all resources
