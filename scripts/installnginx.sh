#!/usr/bin/env bash
#This script install nginx web server
sudo apt-get update
sudo apt-get -y install nginx
sudo /etc/init.d/nginx start
sudo mkdir -p /var/www/html
sudo sh -c "echo 'Holberton School' > /var/www/html/index.html"
sudo sed -i "s|root /usr/share/nginx/html;|root /var/www/html;|g" /etc/nginx/sites-available/default
sudo sed -i "s|_;|_;\n\trewrite ^/redirect_me/$ https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;|g" /etc/nginx/sites-available/default
sudo sed -i "s|_;|_;\n\tadd_header 'X-Served-By' \"\$HOSTNAME\"; |g" /etc/nginx/sites-available/default
sudo service nginx restart
