#!/bin/bash

echo "Install dependencies"
sudo dnf install epel-release python3-pip git ansible -y

echo "Install docker"
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install docker-ce -y
systemctl enable --now docker.service

echo "Instal docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

echo "Baixando repo awx"
sudo git clone -b "17.1.0" https://github.com/ansible/awx.git
cd awx/installer
echo -e "\nlocalhost ansible_connection=local ansible_python_interpreter="/usr/bin/env python3"\npostgres_data_dir=/var/lib/pgdocker\nawx_official=true\nproject_data_dir=/var/lib/awx/projects\nawx_alternate_dns_servers="4.2.2.1,4.2.2.2"\npg_admin_password=postgrespass@123\nadmin_password=Linux@123" >> inventory
grep -v '^#' inventory | grep -v '^$'
sleep 10

sudo ansible-playbook -i inventory install.yml
sudo docker ps
