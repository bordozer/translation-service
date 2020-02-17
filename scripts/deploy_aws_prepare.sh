#!/bin/bash

SERVICE_NAME=$1
if [ -z "$SERVICE_NAME" ]
then
      echo "Service name required (see EC2 tag Name value)"
      exit 1;
fi

EC2_HOST=$(./aws_ec2_instance_dns.sh $SERVICE_NAME)
echo "EC2 host: '$EC2_HOST'"
echo "ssh -i ~/.ssh/aws/aws-vgn-key-3.pem ec2-user@$EC2_HOST"

EC2_USER='ec2-user' \
  && AWS_KEY='aws-vgn-key-3.pem' \
  && APP_JAR_FILE_NAME='translation-service-1.2.jar'

EC2="${EC2_USER}@${EC2_HOST}"

# add to known hosts
ssh-keyscan -H ${EC2_HOST} >> ~/.ssh/known_hosts

echo "-- Copy app jar to EC2 instance"
scp \
    -i "$HOME/.ssh/aws/${AWS_KEY}" \
    "../build/libs/${APP_JAR_FILE_NAME}" \
    "${EC2}:/home/${EC2_USER}/"

echo "-- Deploy app on EC2 instance"
ssh -i "$HOME/.ssh/aws/${AWS_KEY}" "${EC2}" 'bash -s' < deploy_aws_ec2.sh $SERVICE_NAME ${APP_JAR_FILE_NAME} &



