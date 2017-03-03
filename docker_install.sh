#!/bin/bash

yum update -y
yum -y remove docker docker-common container-selinux
yum -y remove docker-selinux
yum install -y yum-utils
#yum-config-manager --add-repo https://docs.docker.com/engine/installation/linux/repo_files/centos/docker.repo
yum makecache fast
#yum -y install docker-engine
curl -fsSL https://get.docker.com/ | sh
echo '{ "insecure-registries":["192.168.10.182:5000"] }' > /etc/docker/daemon.json
#systemctl start docker
systemctl restart docker

mv ./docker-compose /usr/local/bin/
chmod +x /usr/local/bin/docker-compose
