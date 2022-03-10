#!/bin/bash

DIST=`cat /etc/os-release | grep ID_LIKE | awk -F= '{print $2}'| sed 's/"//g'`

if [ "$DIST" = 'debian' ]; then
  echo '===Install apt packages==='
  echo
  sudo apt install git ansible -y
  git clone https://github.com/Emerson89/zabbix-agent.git
  cd zabbix-agent
  ansible-playbook -c local --extra-vars "zabbix_server_ip=127.0.0.1 zabbix_version=5.0 zabbix_hostmetadata=os-linux" playbook.yml
elif [ "$DIST" = 'centos rhel fedora' ]; then
  echo '===Install amz 2==='
  echo
  sudo amazon-linux-extras install epel -y
  sudo yum update -y && yum install git ansible -y
  git clone https://github.com/Emerson89/zabbix-agent.git
  cd zabbix-agent
  ansible-playbook -c local --extra-vars "zabbix_server_ip=127.0.0.1 zabbix_version=5.0 zabbix_hostmetadata=os-linux" playbook.yml
elif [ "$DIST" = 'rhel fedora' ]; then
  echo '===Install RHEL==='
  echo
  sudo yum install epel-release git ansible -y
  git clone https://github.com/Emerson89/zabbix-agent.git
  cd zabbix-agent
  ansible-playbook -c local --extra-vars "zabbix_server_ip=127.0.0.1 zabbix_version=5.0 zabbix_hostmetadata=os-linux" playbook.yml

fi