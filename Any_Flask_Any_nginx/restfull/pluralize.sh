#!/bin/bash
# This script convert of singular to plural
if [ $# -eq 1 ];
then
  perl -ple '$_.=/(ch|sh?|x|z|[^aeiou]o)$/+s/([^aeiou])y$/$1i/+s/fe?$/v/?es:"s"' <<< $1
else
  echo "Usage: ./pluralize <singular>"
fi
