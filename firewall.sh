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
# Allow pop, imap and smtp
iptables -A INPUT -p tcp --dport 25 -j ACCEPT
iptables -A INPUT -p tcp --dport 465 -j ACCEPT
iptables -A INPUT -p tcp --dport 143 -j ACCEPT
iptables -A INPUT -p tcp --dport 993 -j ACCEPT
iptables -A INPUT -p tcp --dport 587 -j ACCEPT
iptables -A INPUT -p tcp --dport 110 -j ACCEPT
iptables -A INPUT -p tcp --dport 995 -j ACCEPT

#
# Allow ongoing & local connections
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -s 127.0.0.1 -j ACCEPT

#
# Accept MySQL
iptables -A INPUT -p tcp --dport 3306 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

#
# Allow all outgoing
iptables -A OUTPUT -m state --state NEW,ESTABLISHED -j ACCEPT

#
# Allow related incoming
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

#
# Loopbacks
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#
# Reject anything that is not established and passes at forward chain.
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -j REJECT

# Allow anything outgoing.
iptables -A OUTPUT -m state --state NEW,RELATED,ESTABLISHED -j ACCEPT

# Reject everything else
iptables -A INPUT -j DROP
