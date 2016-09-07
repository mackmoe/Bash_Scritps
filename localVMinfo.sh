#! /bin/sh
clear
printf "\nxenstore data\n-------------\n"
xenstore-ls data
printf "\nxenstore vm-data\n-------------\n"
xenstore-ls vm-data
printf "\n\n-------------"
printf "\nGathering same data data locally"
printf "\n-------------\n"
printf "\n//cpu info\n";cat /proc/cpuinfo
printf "\n//mem info\n";cat /proc/meminfo
printf "\n\n//nova-agent log\n"
tail /var/log/nova-agent.log
printf "\n\n//ftsab\n";cat /etc/fstab
printf "\n//mounts\n";cat /proc/mounts
printf "\n\n//network interface info\n"
ip a | egrep "inet|link" && netstat -plant && iptables --list | grep ACCEPT
