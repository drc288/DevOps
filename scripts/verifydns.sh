#!/usr/bin/env bash
# This script review subdomains
array=("www" "lb-01" "web-01" "web-02")

print_text(){
  dig "$1"."$2"|awk -v sbd="$1" '/ANSWER SECTION:/{getline; print "The subdomain " sbd " is a " $4 " record and points to " $5}'
}

if [ $# -eq 2 ]
then
  print_text "$2" "$1"
else
  for i in "${array[@]}"
  do
    print_text "$i" "$1"
  done
fi
