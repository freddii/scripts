#!/bin/sh

#https://hyperweb.eu/server/ubuntu1604/firewall/
#https://www.gtkdb.de/index_7_1235.html
	#local NET_MASK1=$(ip r l | grep -v "default" | grep "proto kernel" | awk '{print $1}')
	#echo $NET_MASK1
	dpkg -l | grep -qw iptables || sudo apt-get install iptables -y
	dpkg -l | grep -qw iptables-persistent || sudo apt-get install iptables-persistent -y
	#sudo iptables -A INPUT -s $NET_MASK1 -j ACCEPT
	#sudo iptables- A OUTPUT -d $NET_MASK1 -j ACCEPT
	#sudo systemctl status iptables # ip6tables
	#sudo iptables -L
	sudo iptables --flush
 	sudo iptables --delete-chain
	sudo iptables --policy INPUT DROP
	sudo iptables --policy OUTPUT DROP
	sudo iptables --policy FORWARD DROP
	sudo iptables --append INPUT --in-interface lo --jump ACCEPT
	sudo iptables --append OUTPUT --out-interface lo --jump ACCEPT
	sudo iptables --append INPUT --source 192.168.200.0/24 --jump ACCEPT
	sudo iptables --append OUTPUT --destination 192.168.200.0/24 --jump ACCEPT
	#sudo iptables --append INPUT --jump DROP
	#sudo iptables --append OUTPUT --jump DROP
	#sudo iptables-save --file /etc/iptables/rules.v4 #to be safe after reboot
	sudo iptables-save | sudo tee /etc/iptables/rules.v4
	#sudo iptables-apply /etc/iptables/rules.v4
	#nano /etc/iptables/rules.v4
	#
	#sudo ip6tables -L
	sudo ip6tables --flush
	sudo ip6tables --delete-chain
	sudo ip6tables --policy INPUT DROP
	sudo ip6tables --policy OUTPUT DROP
	sudo ip6tables --policy FORWARD DROP
	#sudo ip6tables-save --file /etc/iptables/rules.v6 #to be safe after reboot
	sudo ip6tables-save | sudo tee /etc/iptables/rules.v6
	#sudo ip6tables-apply /etc/iptables/rules.v6
	#nano /etc/iptables/rules.v6
	#
	echo "########################################"
	echo "output of iptables -L and ip6tables -L:"
	echo "########################################"
	sudo iptables -L && echo && echo && sudo ip6tables -L
