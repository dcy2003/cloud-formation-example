Prerequisites

Create a key pair in the desired region named `cfn-example-key-pair`
Store `cfn-example-key-pair.pem` in the current working directory alongside `create-stack.sh`
`chmod 400 cfn-example-key-pair.pem`

Create IAM user with sufficient privileges create/delete VPCs, Subnets, EC2 Instances, etc. (see `cfn-template.json` for specific actions)
Create access key for this user
Run `aws configure` to set the access key, secret access key, desired region, etc.

Ensure `create-stack.sh` has sufficient privileges (e.g. `chmod +x create-stack.sh` if necessary)
`./create-stack.sh`