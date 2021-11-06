#!/bin/bash

DIST=`cat /etc/os-release | grep ID_LIKE | awk -F= '{print $2}'| sed 's/"//g'`

if [ "$DIST" = 'debian' ]; then
  echo 'Install apt packages'
  sudo apt install git ansible -y
  git clone https://github.com/Emerson89/zabbix-agent.git
  cd zabbix-agent
  sed -i 's/SERVER/127.0.0.1/g' playbook.yml
  sed -i 's/5.0/4.4/g' playbook.yml
  ansible-playbook -c local playbook.yml
elif [ "$DIST" = 'centos rhel fedora' ]; then
  echo 'Install amz 2'
  sudo amazon-linux-extras install epel -y
  sudo yum update && yum install git ansible -y
  git clone https://github.com/Emerson89/zabbix-agent.git
  cd zabbix-agent
  sed -i 's/SERVER/127.0.0.1/g' playbook.yml
  sed -i 's/5.0/4.4/g' playbook.yml
  ansible-playbook -c local playbook.yml
elif [ "$DIST" = 'rhel fedora' ]; then
  echo 'Install RHEL'
  sudo yum install epel-release -y && yum install git -y && yum install ansible -y
  git clone https://github.com/Emerson89/zabbix-agent.git
  cd zabbix-agent
  sed -i 's/SERVER/127.0.0.1/g' playbook.yml
  sed -i 's/5.0/4.4/g' playbook.yml
  ansible-playbook -c local playbook.yml

fi