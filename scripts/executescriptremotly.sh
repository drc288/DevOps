#!/usr/bin/env bash
# This script execute script remotly

if [ $# -eq 4 ]
then
	ssh "$2"@"$1" -i "$3" "bash -s" < "$4"
else
	echo "Usage ./<script>: <IP> <USER> <PRIV-KEY> <FILE>"
fi
