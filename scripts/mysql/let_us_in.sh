#!/usr/bin/env bash
# to verify that servers are properly configured
# create a user and password for both MySQL
# install this script in web1
CREATE USER IF NOT EXISTS 'devopsers'@'localhost' IDENTIFIED BY 'devopsers456';
GRANT REPLICATION CLIENT ON *.* TO 'devopsers'@'localhost';
