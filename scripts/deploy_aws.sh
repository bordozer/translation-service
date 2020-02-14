#!/bin/bash

EC2_USER='ec2-user'
EC2_HOST='ec2-15-188-145-135.eu-west-3.compute.amazonaws.com'

echo "Copy jar to EC2 instance"
scp \
    -i ~/.ssh/aws/vgn-pub-key.pem \
    ../build/libs/translation-service-1.2.jar \
    "${EC2_USER}@${EC2_HOST}:/home/${EC2_USER}/"

echo "Logging to EC2 instance"
ssh -i ~/.ssh/aws/vgn-pub-key.pem "${EC2_USER}@${EC2_HOST}"

echo "Deploy jar"
#fuser -k 8977/tcp
kill -9 "$(lsof -t -i:8977)"
java -ea -Dspring.profiles.active=aws -jar translation-service-1.1.jar

#scp \
#  -i ~/.ssh/aws/vgn-pub-key.pem \
#  ../build/libs/translation-service-1.2.jar \
#  ec2-user@ec2-15-188-77-120.eu-west-3.compute.amazonaws.com:/

#ssh -i ~/.ssh/aws/vgn-pub-key.pem "ec2-user@ec2-15-188-77-120.eu-west-3.compute.amazonaws.com"
#tar xvzf amazon-corretto-8-aarch64-linux-jdk.tar.gz
#mv amazon-corretto-8.242.08.1-linux-aarch64/ java8
#unzip gradle-4.10.2-bin.zip
#mv amazon-corretto-8.242.08.1-linux-aarch64/ java8

