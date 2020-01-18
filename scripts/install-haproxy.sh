#!/usr/bin/env bash
# This script install HAproxy

sudo apt-get update -y
sudo apt-get install haproxy=1.6.\* -y
sudo sh -c "echo 'frontend haproxynode
        bind *:80
        mode http
        default_backend backendnodes' >> /etc/haproxy/haproxy.cfg"

sudo sh -c "echo 'backend backendnodes
        balance roundrobin' >> /etc/haproxy/haproxy.cfg"
#server node1 $IP1:80 check
#server node2 $IP2:80 check' >> /etc/haproxy/haproxy.cfg"

count=1
for IP in "${@}"
do
        sudo sh -c "echo '\tserver node$count $IP:80 check' >> /etc/haproxy/haproxy.cfg"
        count=(1+$count)
done

sudo service haproxy restart
