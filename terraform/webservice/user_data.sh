#! /bin/bash

sudo su

yum install mc -y

#yum install java-1.8.0 -y
#yum install java-1.8.0-openjdk-devel -y

#yum install httpd -y
#systemctl start httpd
#systemctl enable httpd
#echo "<h1>Translation service landing page</h1>" > /var/www/html/index.html

mkdir /var/log/bordozer/translator/
chmod 777 . -R /var/log/bordozer/translator/
