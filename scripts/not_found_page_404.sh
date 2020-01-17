#!/usr/bin/env bash
#This script install nginx web server
sudo apt-get update
sudo apt-get -y install nginx
sudo /etc/init.d/nginx start
sudo sh -c "echo 'Holberton School' > /var/www/html/index.nginx-debian.html"
sudo sed -i "s|_;|_;\n\trewrite ^/redirect_me/$ https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;|g" /etc/nginx/sites-available/default
echo Ceci n\'est pas une page. > /usr/share/nginx/html/custom_404.html
sudo sed -ie "s/^server {$/server {\n\terror_page 404 \/custom_404.html;\n\tlocation = \/custom_404.html {\n\t\troot \/usr\/share\/nginx\/html;\n\t\tinternal;\n\t}/g" /etc/nginx/sites-available/default
sudo service nginx restart
