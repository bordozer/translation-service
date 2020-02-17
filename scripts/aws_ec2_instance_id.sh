#!/bin/bash

SERVICE_NAME=$1
if [ -z "$SERVICE_NAME" ]
then
      echo "Service name required (see EC2 tag Name value)"
      exit 1;
fi

query_result=$(aws ec2 describe-instances \
  --query 'Reservations[*].Instances[*].[InstanceId]' \
  --filters "Name=tag:Name,Values=$SERVICE_NAME" "Name=instance-state-name,Values=running")

ec2_instance="${query_result:31:19}"

echo "$ec2_instance"
# $(./aws_ec2_instance_id.sh)
