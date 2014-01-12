#!/bin/bash

#
# This is a baseline example iptable configuration script
#   Written by: Mo Nash
# Date Created: 01/08/2014
#

echo "Git 'er done!"; sleep 1
echo''

# Flush all current rules from iptables
iptables -F

# Allow connections that are already connected to your server
iptables -A INPUT -i eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow ssh connections on port 22000
iptables -I INPUT 1 -p tcp  --dport 22000 -j ACCEPT

# Allow connections to HTTP/HTTPS
iptables -I INPUT 1 -p tcp --dport 80 -j ACCEPT
iptables -I INPUT 1 -p tcp --dport 443 -j ACCEPT

# Allow ftp connections
iptables -I INPUT 1 -m state --state NEW -m tcp -p tcp --dport 21 -j ACCEPT

# Allow SMTP traffic
iptables -I INPUT 1 -p tcp -m tcp --dport 25 -j ACCEPT
iptables -I INPUT 1 -p tcp -m tcp --dport 465 -j ACCEPT
iptables -I INPUT 1 -p tcp -m tcp --dport 110 -j ACCEPT
iptables -I INPUT 1 -p tcp -m tcp --dport 995 -j ACCEPT
iptables -I INPUT 1 -p tcp -m tcp --dport 143 -j ACCEPT
iptables -I INPUT 1 -p tcp -m tcp --dport 993 -j ACCEPT

# Stop DDOS traffic for syn floods, null packets and XMAS packets
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP

# Drop all connections, and only allow those we have deemed legit
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Save the new rules
/etc/init.d/iptables save

# Restart the service and save new settings
service iptables restart
chkconfig iptables on

echo''

# List rules
iptables -nL

# Lets us know the script is finished
echo ''
echo 'Remember:'
echo 'To enable connecting to any custom port w/root open /etc/ssh/sshd_config'
echo 'uncomment and change the port number to match what you set in the iptable'
echo 'uncomment the PermitRootLogin line then restart the sshd service.'
echo ''