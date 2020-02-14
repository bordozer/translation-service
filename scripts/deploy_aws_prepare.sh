#!/bin/bash

EC2_USER='ec2-user' \
  && EC2_HOST='ec2-15-188-145-26.eu-west-3.compute.amazonaws.com' \
  && JAVA_ARCH_FILE='jdk-8u241-linux-x64.tar.gz' \
  && AWS_KEY='aws-vgn-key-3.pem' \
  && APP_JAR_FILE_NAME='translation-service-1.2.jar'

#ssh-keyscan -H ${EC2_HOST} >> ~/.ssh/known_hosts
#ssh-keyscan -t rsa,dsa HOST 2>&1 | sort -u - ~/.ssh/known_hosts > ~/.ssh/tmp_hosts

echo "-- Copy app jar to EC2 instance"
scp \
    -i "$HOME/.ssh/aws/${AWS_KEY}" \
    "../build/libs/${APP_JAR_FILE_NAME}" \
    "${EC2_USER}@${EC2_HOST}:/home/${EC2_USER}/"

echo "-- Copy Java 1.8 to EC2 instance"
scp \
    -i "$HOME/.ssh/aws/${AWS_KEY}" \
    "./$JAVA_ARCH_FILE" \
    "${EC2_USER}@${EC2_HOST}:/home/${EC2_USER}/"

echo "-- Deploy app on EC2 instance"
ssh root@${EC2_HOST} 'bash -s' < deploy_aws_ec2.sh ${JAVA_ARCH_FILE} ${APP_JAR_FILE_NAME}

#ssh -i ~/.ssh/aws/${AWS_KEY} "${EC2_USER}@${EC2_HOST}"


