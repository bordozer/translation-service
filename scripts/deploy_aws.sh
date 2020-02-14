#!/bin/bash

EC2_HOST='ec2-15-188-77-120.eu-west-3.compute.amazonaws.com'
EC2_USER='ec2-user'
JAVA_ZIP_NAME='amazon-corretto-8-aarch64-linux-jdk.tar.gz'

echo "Copy jar to EC2 instance"
scp \
    -i ~/.ssh/aws/vgn-pub-key.pem \
    ../build/libs/translation-service-1.2.jar \
    "${EC2_USER}@${EC2_HOST}":/

scp \
  -i ~/.ssh/aws/vgn-pub-key.pem \
  ../build/libs/translation-service-1.2.jar \
  ec2-user@ec2-15-188-77-120.eu-west-3.compute.amazonaws.com:/home/ec2-user/


echo "Logging to EC2 instance"
ssh -i ~/.ssh/aws/vgn-pub-key.pem "${EC2_USER}@${EC2_HOST}"

echo "Downloading ${JAVA_ZIP_NAME}"
cd /home/${EC2_USER} || exit 1
wget https://corretto.aws/downloads/latest/${JAVA_ZIP_NAME}
tar xvzf ${JAVA_ZIP_NAME}
mv ${JAVA_ZIP_NAME} java8
export JAVA_HOME=~/java8

#echo "Downloading gradle"
#wget "https://services.gradle.org/distributions/gradle-4.10.2-bin.zip"
#unzip gradle-4.10.2-bin.zip
#mv gradle-4.10.2 gradle
#export GRADLE_HOME=~/gradle
#export PATH=$JAVA_HOME/bin:$GRADLE_HOME/bin:$PATH

export PATH=$JAVA_HOME/bin:$PATH

echo "Deploy jar"
#fuser -k 8977/tcp
kill -9 "$(lsof -t -i:8977)"
java -ea -Dspring.profiles.active=local -jar build/libs/translation-service-1.1.jar

#scp \
#  -i ~/.ssh/aws/vgn-pub-key.pem \
#  ../build/libs/translation-service-1.2.jar \
#  ec2-user@ec2-15-188-77-120.eu-west-3.compute.amazonaws.com:/

#ssh -i ~/.ssh/aws/vgn-pub-key.pem "ec2-user@ec2-15-188-77-120.eu-west-3.compute.amazonaws.com"
#tar xvzf amazon-corretto-8-aarch64-linux-jdk.tar.gz
#mv amazon-corretto-8.242.08.1-linux-aarch64/ java8
#unzip gradle-4.10.2-bin.zip
#mv amazon-corretto-8.242.08.1-linux-aarch64/ java8

