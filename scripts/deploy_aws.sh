#!/bin/bash

EC2_USER='ec2-user'
EC2_HOST='ec2-15-236-35-5.eu-west-3.compute.amazonaws.com'
JAVA_ARCH_FILE='jdk-8u241-linux-x64.tar.gz'

echo "-- Copy app jar to EC2 instance"
# TODO: autoadd to known hosts
scp \
    -i ~/.ssh/aws/vgn-pub-key.pem \
    ../build/libs/translation-service-1.2.jar \
    "${EC2_USER}@${EC2_HOST}:/home/${EC2_USER}/"

echo "-- Copy Java 1.8 to EC2 instance"
scp \
    -i ~/.ssh/aws/vgn-pub-key.pem \
    ./$JAVA_ARCH_FILE \
    "${EC2_USER}@${EC2_HOST}:/home/${EC2_USER}/"

echo "-- Logging to EC2 instance"
ssh -i ~/.ssh/aws/vgn-pub-key.pem "${EC2_USER}@${EC2_HOST}"

echo "-- Configuring Java"
tar xvzf $JAVA_ARCH_FILE
mv jdk1.8.0_241 java8
export JAVA_HOME=~/java8
export PATH=$JAVA_HOME/bin:$PATH
$JAVA_HOME/bin/java -version

echo "-- Deploy jar"
#fuser -k 8977/tcp
kill -9 "$(lsof -t -i:8977)"
$JAVA_HOME/bin/java -ea -Dspring.profiles.active=aws -jar translation-service-1.2.jar


