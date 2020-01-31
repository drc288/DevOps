#!/usr/bin/env bash
# Mysql dump in a compressed archi.targ
date_up=$(date +"%d-%m-%Y")
mysqldump -u root  -p$1 --all-databases > backup.sql
tar cfz "$date_up".tar.gz backup.sql
