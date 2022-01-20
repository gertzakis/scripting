#!/bin/bash
#
# Firewall Rules
#
iptables -F INPUT
iptables -F OUTPUT
iptables -F FORWARD

#
# Accept Established ssh & telnet.
iptables -A INPUT -p tcp --dport ssh -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -p tcp --dport telnet -j ACCEPT

#
# Allow http & https
iptables -A INPUT -p tcp --dport 80 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT

#
# Allow ftp
iptables -A INPUT -p tcp --dport 21 -j ACCEPT

#
# Allow webmin & cockpit & 5081
iptables -A INPUT -p tcp --dport 10000 -j ACCEPT
iptables -A INPUT -p tcp --dport 9090 -j ACCEPT
iptables -A INPUT -p tcp --dport 5081 -j ACCEPT

#
# Accept only 1 ping per second. Faster than that gets dropped & logged.
iptables -A INPUT -p icmp -m icmp --icmp-type echo-request -m limit --limit 1/second -j ACCEPT
iptables -A INPUT -p icmp -m icmp --icmp-type echo-request -j LOG
iptables -A INPUT -p icmp -m icmp --icmp-type echo-request -j DROP

#
# Allow ongoing & local connections
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -s 127.0.0.1 -j ACCEPT

#
# Accept MySQL
#iptables -A INPUT -p tcp --dport 3306 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

#
# Allow all outgoing
iptables -A OUTPUT -m state --state NEW,ESTABLISHED -j ACCEPT

#
# Loopbacks
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#
#DOCKER
iptables -N DOCKER
iptables -N DOCKER-ISOLATION
iptables -N DOCKER-USER
iptables -A FORWARD -j DOCKER-USER
iptables -A FORWARD -j DOCKER-ISOLATION
iptables -A FORWARD -o docker0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -o docker0 -j DOCKER
iptables -A FORWARD -i docker0 ! -o docker0 -j ACCEPT
iptables -A FORWARD -i docker0 -o docker0 -j ACCEPT
iptables -A DOCKER-ISOLATION -j RETURN
iptables -A DOCKER-USER -j RETURN

#
# Reject anything that is not established and passes at forward chain.
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -j REJECT

# Allow anything outgoing.
iptables -A OUTPUT -m state --state NEW,RELATED,ESTABLISHED -j ACCEPT

# Reject everything else
iptables -A INPUT -j DROP

#
# Policies
iptables -P INPUT ACCEPT
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

#
# Save rules
iptables-save
