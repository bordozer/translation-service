#! /bin/bash
sudo su
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "<h1>Landing page</h1>" > /var/www/html/index.html

