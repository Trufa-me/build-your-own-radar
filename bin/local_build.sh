#!/bin/bash

# Login to ECR
#eval $(aws ecr get-login --region eu-west-1) # add --no-include-email flag in later versions of aws cli

REGISTRY_URL=796467622059.dkr.ecr.eu-west-1.amazonaws.com
JOB_NAME=generic-service

IMAGE_TAG=master.local

# Build Docker image
docker build --no-cache=true --build-arg AWS_ACCESS_KEY_ID=$(aws ssm get-parameter --with-decryption --name /circleci/access/key --query 'Parameter.Value' --output text) --build-arg AWS_SECRET_ACCESS_KEY=$(aws ssm get-parameter --with-decryption --name /circleci/access/secret --query 'Parameter.Value' --output text) -t $REGISTRY_URL/${JOB_NAME} . || exit 1
