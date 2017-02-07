#!/bin/bash

aws cloudformation create-stack \
    --stack-name MyTestStack \
    --template-body file://cfn-template.json \
    --parameters ParameterKey=MyIP,ParameterValue=`curl -s http://whatismyip.akamai.com/` \
    ParameterKey=EC2SshKey,ParameterValue=cfn-key-pair \
    ParameterKey=S3LocationOfPrivateKey,ParameterValue=s3://asc-cloudformation-resources/cfn-key-pair.pem \
    --capabilities CAPABILITY_NAMED_IAM