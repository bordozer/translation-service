#!/bin/bash

#dns=''

#function extract_dns {
#  str="$1"
#  IFS='"'
#  echo "======$str"
#  readarray -d : -t strarr <<< "$str"
#  dns=${strarr[1]}
#}

SERVICE_EC2_TAG=$1
if [ -z "$SERVICE_EC2_TAG" ]
then
      echo "Service tag:name required (see EC2 tag Name value)"
      exit 1;
fi

EC2_INSTANCE_ID=$(./aws_ec2_instance_id.sh "$SERVICE_EC2_TAG")
if [ -z "$EC2_INSTANCE_ID" ]
then
      echo "Cannot get EC2 instance ID for tag '$SERVICE_EC2_TAG'"
      exit 1;
fi

query_result=$(aws ec2 describe-instances --instance-ids "$EC2_INSTANCE_ID" --query "Reservations[].Instances[].PublicDnsName")

#pat='"(.*?)"'
#[[ "$query_result" =~ $pat ]]
#echo "${BASH_REMATCH[0]}"

dns=$(grep -o '".*"' "$query_result" | sed 's/"//g')
echo $dns
