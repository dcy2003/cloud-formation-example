#!/bin/bash

aws cloudformation create-stack \
    --stack-name MyTestStack \
    --template-body file://cfn-template.json \
    --parameters ParameterKey=MyIP,ParameterValue=`curl -s http://whatismyip.akamai.com/` \
    ParameterKey=EC2SshKey,ParameterValue=cfn-example-key-pair \
    ParameterKey=BootstrapScript,ParameterValue=`cat bootstrap.sh | base64` \
    --capabilities CAPABILITY_NAMED_IAM