# Start Automating

## Description

To start on DevOps, you need machines to provision, so you can see the paralelism and efficiency. I made a way of doing that using Docker, so you can create containers in a fast way, and start using things like ansible, terraform and more DevOps Tools.

## Prerequisites
  - Docker
  - Ansible
## Install

### Docker

First of all, we need the docker image we are going to uses to deploy our servers, it is based on this docker image 'rastasheep/ubuntu-sshd:18.04' so I recommend to pull that images

```
docker pull rastasheep/ubuntu-sshd:18.04
```

Based on that image we are going to build the one that we are going to use.
Pick your favorite text editor and modify some parameters:
 - 9th line: put the user:passsword you want for your non root user
 - 17th & 18th line: Put the public key you are going to use to login to your machines with ssh

Once you have this, we can build our image using 
```
docker build -t alex/ubuntuserver:18.04 .
```

I also recommend to create a new docker network for this machines:
```
docker network create virtual_servers
```

You can see the network of your containers by showing the network and matching your NETWORK ID:
```
docker network ls
ip a | grep NETWORK ID | grep inet

```

### Ansible

With ansible you need to edit your /etc/ansible/hosts file and add the network of your docker machines you are going to provision, in my case:
```
[docker-servers]
172.18.0.[2:10]
```


## Usage 

To the deploy the machines, you can use the following scripts:

This will create a single server:
```
scripts/create-server.sh
```
If you want to create multiple servers you can use:
```
scripts/create-server.sh N
```
where N is the number of servers you want to create.

To delete a single server you can use:
```
scripts/delete-server.sh N
```
where N is the number of the server you want to delete.
You can algo use it without parameters to delete all servers:
```
scripts/delete-server.sh
```
