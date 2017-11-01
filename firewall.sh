#!/bin/bash
#
# Firewall Rules
#
iptables -F INPUT
iptables -F OUTPUT
iptables -F FORWARD
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

#
# Accept Established ssh & telnet.
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -p tcp --dport ssh -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -p tcp --dport telnet -j ACCEPT
#
# Accept only 1 ping per second. Faster than that gets dropped & logged.
iptables -A INPUT -p icmp -m icmp --icmp-type echo-request -m limit --limit 1/second -j ACCEPT
iptables -A INPUT -p icmp -m icmp --icmp-type echo-request -j LOG
iptables -A INPUT -p icmp -m icmp --icmp-type echo-request -j DROP

#
# Accept ongoing connections
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

#
# Reject anything that is not established and passes at forward chain.
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -j REJECT


