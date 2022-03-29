#!/bin/bash

DIST=`cat /etc/os-release | grep ID_LIKE | awk -F= '{print $2}'| sed 's/"//g'`

if [ "$DIST" = 'debian' ]; then
  echo '===Install apt packages==='
  echo
  #sudo apt remove zabbix-agent --purge -y
  sudo apt-add-repository ppa:ansible/ansible
  sudo apt update
  sudo apt install git ansible -y
  cd /tmp
  git clone https://github.com/Emerson89/zabbix-agent.git
  cd zabbix-agent
  ansible-playbook -c local -i hosts --extra-vars "zabbix_server_ip=10.99.154.8,10.99.16.100,10.99.188.197 zabbix_version=6.0 zabbix_agent2_install=True porta_agent2=10050 zabbix_hostmetadata=os-linux-serasa" playbook.yml
  rm -rf /tmp/zabbix-agent
elif [ "$DIST" = 'centos rhel fedora' ]; then
  echo '===Install amz 2==='
  echo
  #sudo yum remove zabbix-agent -y
  sudo amazon-linux-extras install epel -y
  sudo yum install git ansible -y
  cd /tmp
  git clone https://github.com/Emerson89/zabbix-agent.git
  cd zabbix-agent
  ansible-playbook -c local -i hosts --extra-vars "zabbix_server_ip=10.99.154.8,10.99.16.100,10.99.188.197 zabbix_version=6.0 zabbix_agent2_install=True porta_agent2=10050 zabbix_hostmetadata=os-linux-serasa" playbook.yml
  rm -rf /tmp/zabbix-agent
elif [ "$DIST" = 'rhel fedora' ]; then
  echo '===Install RHEL==='
  echo
  #sudo yum remove zabbix-agent -y
  sudo yum install git ansible -y
  cd /tmp
  git clone https://github.com/Emerson89/zabbix-agent.git
  cd zabbix-agent
  ansible-playbook -c local -i hosts --extra-vars "zabbix_server_ip=10.99.154.8,10.99.16.100,10.99.188.197 zabbix_version=6.0 zabbix_agent2_install=True porta_agent2=10050 zabbix_hostmetadata=os-linux-serasa" playbook.yml
  rm -rf /tmp/zabbix-agent
fi