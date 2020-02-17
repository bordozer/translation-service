#!/bin/bash

SERVICE_EC2_TAG=$1
if [ -z "$SERVICE_EC2_TAG" ]
then
      echo "Service tag:name required (see EC2 tag Name value)"
      exit 1;
fi

query_result=$(aws ec2 describe-instances \
  --query 'Reservations[*].Instances[*].[InstanceId]' \
  --filters "Name=tag:Name,Values=$SERVICE_EC2_TAG" "Name=instance-state-name,Values=running")

ec2_instance="${query_result:31:19}"

echo "$ec2_instance"
