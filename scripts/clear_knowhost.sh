#!/usr/bin/env bash
# This script delete line with sed in the file know_host
sudo sed -i '' -e "/^$1/d" ~/.ssh/known_hosts
