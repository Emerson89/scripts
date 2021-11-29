#!/bin/bash

DIST=`cat /etc/os-release | grep ID_LIKE | awk -F= '{print $2}'| sed 's/"//g'`

if [ "$DIST" = 'debian' ]; then
  sudo wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
  sudo dpkg -i amazon-ssm-agent.deb
  sudo systemctl enable amazon-ssm-agent
  sudo systemctl restart amazon-ssm-agent
elif [ "$DIST" = 'centos rhel fedora' ]; then
  sudo yum install -y curl
  sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
  sudo systemctl restart amazon-ssm-agent
  sudo systemctl enable amazon-ssm-agent
elif [ "$DIST" = 'rhel fedora' ]; then
  sudo yum install -y curl
  sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
  sudo systemctl restart amazon-ssm-agent
  sudo systemctl enable amazon-ssm-agent
fi