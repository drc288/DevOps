#!/usr/bin/env bash
# This scrip install a puppet clien or master server, using the options 1 or 2
# ############################################################################
# #                           Puppet installer                               #
# ############################################################################
#
# Create the configuratioen, get argv to get the installer
if [ "$#" -eq 1 ]; then
  if [ "$(whoami)" != root ]; then
    echo "Please run this script as root or using sudo"
    exit
  else
    if [ "${1^^}" == "AGENT" ]; then
      echo "yes agent"
    elif [ "${1^^}" == "MASTER" ]; then
      echo "yes master"
    elif [ "${1^^}" == "ALL" ]; then
      echo "all packages"
    else
      echo "The option '$1' is no recogniced"
    fi
  fi
else
  echo "Usage:"
  echo "  ./service_puppet.sh agent to create a client"
  echo "  ./service_puppet.sh master to create a server"
fi
