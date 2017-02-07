# EC2 Bootstrap Example 

**Uses CloudFormation, cloud-init, and Ansible to provision and bootstrap three EC2 instances** (an Ansible master node and two slave nodes)

The bootstrap process:

* Installs Ansible
* Download resources from S3
* Dynamically generates configuration files
* Clones a Git repository
* Executes an Ansible playbook to configure the other two slave instances

## Prerequisites:

* AWS account
* [AWS CLI](https://aws.amazon.com/cli/)
* IAM user with sufficient privileges + access key
* Run `aws configure` to set the desired region, access key, secret access key
* Create a key pair in the desired AWS region
 * Download the private key
 * Upload the private key to a S3 bucket (do not make public)

## To Run:

* Edit `create-stack.sh` as necessary:
 * `EC2SshKey` should match the name you gave to the key pair you created in AWS
 * `S3LocationOfPrivateKey` is the fully qualified location of the private key stored in an S3 bucket
 * `GitHubRepository` is the Git repository that contains the Ansible playbook you will run
 * `AnsiblePlaybook` is the name of the Ansible playbook to run on the slave nodes
 * See `cfn-template.json` for complete list of parameters
* Run `./create-stack.sh` to provison and configure all resources.

## Cleanup:

* When finished, run `./delete-stack.sh` to tear down all resources.
