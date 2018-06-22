#!/bin/bash

ACTION=$1
PUBLIC_IP_ADDRESS=$(wget -qO- http://checkip.amazonaws.com)
PUBLIC_IP_ADDRESS_CIDR=$PUBLIC_IP_ADDRESS/32

if [ "$2" = "verdaccio" ]
then
  SECURITY_GROUP_ID=sg-b6cdb9cd
elif [ "$2" = "nexus" ]
then
  SECURITY_GROUP_ID=sg-b6cdb9cd
elif [ "$2" = "dev-ecs" ]
then
  SECURITY_GROUP_ID=sg-90d717ea
else
  echo "Missing sg target"
  exit 1
fi

if [ "$ACTION" = "authorize" ]
then
  IPS_LIST=$(aws ec2 describe-security-groups --group-ids ${SECURITY_GROUP_ID} --query 'SecurityGroups[*].IpPermissions[*].IpRanges[*].CidrIp' --output text --region eu-west-1)
  if [[ $IPS_LIST = *"${PUBLIC_IP_ADDRESS}"* ]]; then
    echo "$PUBLIC_IP_ADDRESS - is there!"
  else
    aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 443 --cidr $PUBLIC_IP_ADDRESS_CIDR --region eu-west-1 || exit 1
    echo "CircleCi - $PUBLIC_IP_ADDRESS - access granted"
  fi
elif [ "$ACTION" = "revoke" ]
then
  aws ec2 revoke-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 443, "ToPort": 443, "IpRanges": [{"CidrIp": "'"${PUBLIC_IP_ADDRESS_CIDR}"'"}]}]' --region eu-west-1
  echo "CircleCi - $PUBLIC_IP_ADDRESS - access revoked"
else
  echo "Bad argument"
  exit 1
fi

#
