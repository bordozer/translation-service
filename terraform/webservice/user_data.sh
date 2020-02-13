#! /bin/bash
sudo su
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "<h1>landing page</h1>" > /var/www/html/index.html

#sudo apt-get update
#sudo apt-get install -y apache2
#sudo systemctl start apache2
#sudo systemctl enable apache2
#echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
