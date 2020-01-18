#!/usr/bin/env bash
# This script create new servers with nginx
path_key=$1
appservers_ip=("192.168.33.10" "192.168.33.11")
script="installnginx.sh"

for i in "${appservers_ip[@]}"
do
	# subir el file con scp
	./transferfiletoserver.sh "./$script" "$i" 'vagrant' "$path_key"
	# ejecutar el file
	ssh -i "$path_key" "vagrant@$i" "sh ~/$script"
	# validar que se haya instalado
	curl -sI "$i"
	# remover el file
	ssh -i "$path_key" "vagrant@$i" "rm ~/$script"
done

