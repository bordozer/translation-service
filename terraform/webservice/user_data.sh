#! /bin/bash
sudo su
yum install mc -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "<h1>Translation cervice landing page</h1>" > /var/www/html/index.html

