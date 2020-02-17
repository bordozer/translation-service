#!/bin/bash

GREEN='\e[32m'
RED='\e[31m'
DEFAULT='\e[39m'
YELLOW='\e[93m'

SERVICE_EC2_TAG=$1
if [ -z "$SERVICE_EC2_TAG" ]
then
      echo -e "$RED Service tag:name required (see EC2 tag Name value)$DEFAULT"
      exit 1;
fi

EC2_HOST=$(./aws_ec2_instance_dns.sh $SERVICE_EC2_TAG)
echo "$YELLOW EC2 host: '$EC2_HOST' $DEFAULT"
echo "$GREEN ssh -i ~/.ssh/aws/aws-vgn-key-3.pem ec2-user@$EC2_HOST $DEFAULT"

EC2_USER='ec2-user' \
  && AWS_KEY='aws-vgn-key-3.pem' \
  && APP_JAR_FILE_NAME='translation-service-1.2.jar'

EC2="${EC2_USER}@${EC2_HOST}"

# add to known hosts
ssh-keyscan -H ${EC2_HOST} >> ~/.ssh/known_hosts

echo "$YELLOW -- Copy app jar to EC2 instance $DEFAULT"
scp \
    -i "$HOME/.ssh/aws/${AWS_KEY}" \
    "../build/libs/${APP_JAR_FILE_NAME}" \
    "${EC2}:/home/${EC2_USER}/"

echo "$YELLOW -- Deploy app on EC2 instance $DEFAULT"
ssh -i "$HOME/.ssh/aws/${AWS_KEY}" "${EC2}" 'bash -s' < deploy_aws_ec2.sh ${APP_JAR_FILE_NAME} &



