#!/bin/bash

aws cloudformation create-stack \
    --stack-name UserDataTestStack \
    --template-body file://cfn-template.yml \
    --parameters ParameterKey=UserData,ParameterValue=`cat bootstrap.sh | base64` \
    ParameterKey=AmiID,ParameterValue=ami-38cd975d \
    ParameterKey=InstanceName,ParameterValue=TempTestInstance \
    ParameterKey=SecurityGroupId,ParameterValue=sg-4ecb7c27