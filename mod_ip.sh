#!/bin/bash

sudo sed -i 's/Server=10.20.253.180/Server=zabbix.monitoramento.vpc/g' /etc/zabbix/zabbix_agentd.conf
sudo sed -i 's/ServerActive=10.20.253.180/ServerActive=zabbix.monitoramento.vpc/g' /etc/zabbix/zabbix_agentd.conf
sudo systemctl restart zabbix-agent