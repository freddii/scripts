#!/bin/sh

	#sudo iptables -L
	sudo iptables --flush
	sudo iptables --delete-chain
	sudo iptables --policy INPUT ACCEPT
	sudo iptables --policy OUTPUT ACCEPT
	sudo iptables --policy FORWARD ACCEPT
#sudo iptables -A OUTPUT -p tcp -m string --string "www.amazonaws.com" --algo kmp -j REJECT
#sudo iptables -A INPUT -p tcp -m tcp -d www.amazonaws.com -j DROP
	#sudo iptables-save --file /etc/iptables/rules.v4 #to be safe after reboot
	sudo iptables-save | sudo tee /etc/iptables/rules.v4
	#nano /etc/iptables/rules.v4
	#
	#sudo ip6tables -L
	sudo ip6tables --flush
	sudo ip6tables --delete-chain
	sudo ip6tables --policy INPUT ACCEPT
	sudo ip6tables --policy OUTPUT ACCEPT
	sudo ip6tables --policy FORWARD ACCEPT
	#sudo ip6tables-save --file /etc/iptables/rules.v6 #to be safe after reboot
	sudo ip6tables-save | sudo tee /etc/iptables/rules.v6
	#nano /etc/iptables/rules.v6
	#
	echo "########################################"
	echo "output of iptables -L and ip6tables -L:"
	echo "########################################"
	sudo iptables -L && echo && echo && sudo ip6tables -L
	echo "now reboot manually (otherwise might run into dns problems)"
