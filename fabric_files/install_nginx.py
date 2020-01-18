#!/usr/bin/python3
from fabric.api import env, run, sudo
from sys import argv
env.hosts = ["192.168.33.10", "192.168.33.11"]


def install_nginx():
    """
    install_nginx - update the server and install nginx
    and add a template
    """
    try:
        run("sudo apt-get update")
        run("sudo apt-get -y install nginx")
        run("sudo service nginx start")
        run("sudo mkdir -p /var/www/html")
        run("sudo touch /var/www/html/index.html")
        sudo("sed -i 's|root /usr/share/nginx/html;|root /var/www/html;|g' /etc/nginx/sites-available/default")
        sudo("echo 'Holberton School' > /var/www/html/index.html")
        run("sudo service nginx restart")
    except Exception:
        pass