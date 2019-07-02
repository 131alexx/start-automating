#!/bin/bash

server="virtual_server$1"
delete_server(){
	echo 
	echo "Deleting server $server"
	
	if [ $(docker ps | grep $server | wc -l) != "0" ]; then
		echo "$server Stoping..."
		docker stop $server > /dev/null
	fi
	
	if [ $(docker ps -a | grep $server | wc -l) != "0" ]; then
		echo "$server Removing..."
		docker rm $server > /dev/null
	fi
}

if [ $server == "virtual_server" ]; then
	read -p "Are you sure you want to delete ALL servers? [Y/n]  " sure
	if [ $sure != "Y" ]; then
		echo "Exiting..."
		exit 1
	fi
	
	echo "Deleting all servers"
	num=1
	while [ $(docker ps -a | grep virtual_server | wc -l) != "0" ];do
		server="virtual_server$num"
		delete_server
		((num++))
	done
else
	delete_server
fi
