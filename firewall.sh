#!/bin/bash

# Interface da Internet
ifinternet="enp0s3"

# Interface da rede local
iflocal="enp0s8"

iniciar() {
	modprobe iptable_nat
	echo 1 > /proc/sys/net/ipv4/ip_forward
	iptables -t nat -A POSTROUTING -o $ifinternet -j MASQUERADE
	iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
	echo 1 > /proc/sys/net/ipv4/conf/default/rp_filter
	iptables -A INPUT -m state --state INVALID -j DROP
	iptables -A INPUT -i lo -j ACCEPT
	iptables -A INPUT -i $iflocal -j ACCEPT
	iptables -A INPUT -p tcp --dport 22 -j ACCEPT
	iptables -A INPUT -p tcp --syn -j DROP
}
parar(){
	iptables -F
	iptables -F -t nat
}

case "$1" in
	"start") iniciar ;;
	"stop") parar ;;
	"restart") parar; iniciar ;;
	*) echo "Use os parâmetros start ou stop"
esac