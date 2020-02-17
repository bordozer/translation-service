#!/bin/bash

EC2_HOST='ec2-35-180-187-168.eu-west-3.compute.amazonaws.com' \
  && EC2_USER='ec2-user' \
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
ssh -i "$HOME/.ssh/aws/${AWS_KEY}" "${EC2}" 'bash -s' < deploy_aws_ec2.sh ${APP_JAR_FILE_NAME} &



