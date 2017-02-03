## Prerequisites

1. An AWS account
2. Create an IAM user with either admin privileges or the ability to create/delete VPCs, Subnets, EC2 Instances, etc. (see `cfn-template.json` for specific actions)
3. Create an access key for this user
4. Install the [AWS CLI](https://aws.amazon.com/cli/)
5. Run `aws configure` to set the access key, secret access key, desired region, etc.
6. `git clone https://github.com/dcy2003/cloud-formation-example.git`
7. Create a key pair in the desired region named `cfn-example-key-pair`
8. `cd cloud-formation-example` and store `cfn-example-key-pair.pem` in the current working directory alongside `create-stack.sh`
9. Ensure permissions are correct for the .pem file: `chmod 400 cfn-example-key-pair.pem`
10. Ensure `create-stack.sh` has sufficient privileges (e.g. `chmod +x create-stack.sh` if necessary)

## Use CloudFormation to provision all resources

2. Run `./create-stack.sh`
3. Explore!
4. Run `./delete-stack.sh` to tear down all resources when finished