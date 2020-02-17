#!/bin/bash

SERVICE_NAME=$1
if [ -z "$SERVICE_NAME" ]
then
      echo "Service name required (see EC2 tag Name value)"
      exit 1;
fi

EC2_INSTANCE_ID=$(./aws_ec2_instance_id.sh $SERVICE_NAME)
if [ -z "$EC2_INSTANCE_ID" ]
then
      echo "Cannot get EC2 instance ID for '$SERVICE_NAME'"
      exit 1;
fi

query_result=$(aws ec2 describe-instances --instance-ids $EC2_INSTANCE_ID --query "Reservations[].Instances[].PublicDnsName")
#query_result="[ \"ec2-15-188-77-62.eu-west-3.compute.amazonaws.com\", \"\" ]"

dns="${query_result:7:48}"

echo "$dns";
