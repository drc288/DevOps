#!/usr/bin/python3
from fabric.api import env, run, sudo
env.hosts = ["192.168.33.50"]


def install_haproxy():
    """Install Haproxy in the version"""
    # run("sudo apt-get update -y")
    run("sudo add-apt-repository ppa:vbernat/haproxy-1.6")
    run("sudo apt-get update")
    run("sudo apt-get install haproxy=1.6.\\* -y")
    sudo("echo 'frontend haproxynode\n\tbind *:80\n\tmode http\n\tdefault_backend backendnodes' >> /etc/haproxy/haproxy.cfg")
    sudo("echo 'backend backendnodes\n\tbalance roundrobin' >> /etc/haproxy/haproxy.cfg")
    sudo("echo '\tserver node1 192.168.33.10:80 check' >> /etc/haproxy/haproxy.cfg")
    sudo("echo '\tserver node2 192.168.33.11:80 check' >> /etc/haproxy/haproxy.cfg")
    run("sudo service haproxy restart")