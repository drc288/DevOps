#!/usr/bin/env bash
# This script install ssl certificate
DOMAIN='www.bitcoincucuta.tech'
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install certbot
sudo mkdir -p /etc/haproxy/ssl
sudo chmod -R go-rwx /etc/haproxy/ssl
sudo certbot certonly --standalone -d $DOMAIN
sudo -E bash -c "cat /etc/letsencrypt/live/$DOMAIN/fullchain.pem /etc/letsencrypt/live/$DOMAIN/privkey.pem > /etc/haproxy/ssl/$DOMAIN.pem"
