#!/bin/bash

aws cloudformation create-stack \
    --stack-name MyTestStack \
    --template-body file://cfn-template.json \
    --parameters ParameterKey=MyIP,ParameterValue=`curl -s http://whatismyip.akamai.com/` \
    ParameterKey=EC2SshKey,ParameterValue=cfn-key-pair \
    ParameterKey=S3LocationOfPrivateKey,ParameterValue=s3://asc-cloudformation-resources/cfn-key-pair.pem \
    ParameterKey=GitHubRepository,ParameterValue=git@github.com:dcy2003/cloud-formation-example.git \
    ParameterKey=AnsiblePlaybook,ParameterValue=ansible-playbook.yaml \
    --capabilities CAPABILITY_NAMED_IAM