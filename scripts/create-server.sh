#!/bin/bash

num=1
server_create(){
	while [ $(docker ps -a | grep virtual_server$num | wc -l) != "0" ]; do
	((num++))
	done
	
	docker run -d --name virtual_server$num --network=virtual_servers  alex/ubuntuserver:18.04 > /dev/null
	echo 	
	echo "New server created: virtual_server$num"
}
if [[ $1 == "" ]]; then
	echo "Creating a new server"
	server_create
else
	if [[ $1 =~ ^[0-9]+$ ]]; then
		echo "Creating $1 servers"
		for(( i=0 ; i<$1 ; i++ )) do
			server_create
		done
	else
		echo "Parameter must be a number"
		exit 1
	fi
fi
exit 0
