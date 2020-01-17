#!/bin/bash
# This script execute rules ufw
sudo apt-get install ufw
sudo ufw default deny incoming
sudo ufw enable
sudo ufw allow ssh/tcp
sudo ufw allow https/tcp
sudo ufw allow http/tcp
sudo ufw reload
