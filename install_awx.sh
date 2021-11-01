#!/bin/bash

echo "Disable selinux"
sudo setenforce 0
sudo sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config
cat /etc/selinux/config | grep SELINUX=

echo "Install dependencies"
sudo yum install epel-release -y
sudo yum install curl git gcc gcc-c++ nodejs gettext device-mapper-persistent-data lvm2 bzip2 python3-pip ansible -y

echo "Install docker"
sudo yum config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce -y
systemctl enable --now docker.service

echo "Set python alternatives"
sudo alternatives --set python /usr/bin/python3
sudo pip3 install docker-compose

echo "Instal docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

echo "Baixando repo awx"
sudo git clone -b "17.1.0" https://github.com/ansible/awx.git
cd awx/installer
senha=$(openssl rand -base64 30) 
echo -e "\nlocalhost ansible_connection=local ansible_python_interpreter="/usr/bin/env python3"\npostgres_data_dir=/var/lib/pgdocker\nawx_official=true\nproject_data_dir=/var/lib/awx/projects\nawx_alternate_dns_servers="4.2.2.1,4.2.2.2"\npg_admin_password=postgrespass@123\nadmin_password=Linux@123\nsecret_key=$senha" >> inventory
grep -v '^#' inventory | grep -v '^$'
sleep 10
sudo ansible-playbook -i inventory install.yml
sudo docker ps
