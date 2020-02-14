#! /bin/bash

sudo su
#yum install mc -y
#yum install httpd -y
#systemctl start httpd
#systemctl enable httpd
yum install java-1.8.0 -y

echo "<h1>Translation service landing page</h1>" > /var/www/html/index.html

#su ec2-user

#JAVA_ZIP_NAME='amazon-corretto-8-aarch64-linux-jdk.tar.gz'
#wget https://corretto.aws/downloads/latest/${JAVA_ZIP_NAME}
#tar xvzf ${JAVA_ZIP_NAME}
#mv amazon-corretto-8.242.08.1-linux-aarch64 java8

#export JAVA_HOME=~/java8
#export PATH=$JAVA_HOME/bin:$PATH
