#!/bin/bash

IP=$1
METADATA=$2

sed -i '98s/$/,'$IP'/' /etc/zabbix/zabbix_agentd.conf
sed -i '139s/$/,'$IP'/' /etc/zabbix/zabbix_agentd.conf
sed -i '169s/#//' /etc/zabbix/zabbix_agentd.conf
sed -i '169s/$/'$METADATA'/' /etc/zabbix/zabbix_agentd.conf