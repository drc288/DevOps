#!/usr/bin/env bash
# This script execute script remotly
ssh vagrant@"$1" -i scripts/web-01_private_key "bash -s" < scripts/./delete_nginx.sh
