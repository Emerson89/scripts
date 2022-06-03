#!/bin/bash

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
export ASG=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name 'Fulltrack Web Service' --query 'AutoScalingGroups[*].Tags[?Key==`Name`].Value' --output text)
sed -i 's/Hostname=.*/Hostname='$ASG'-'$HOSTNAME'/g' /etc/zabbix/zabbix_agentd.conf
sed -i 's/#HostMetadada=/HostMetadada=os-linux/g' /etc/zabbix/zabbix_agentd.conf
systemctl restart zabbix-agent

