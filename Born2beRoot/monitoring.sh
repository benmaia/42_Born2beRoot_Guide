#!/bin/bash

arch=$(uname -a)
phyproc=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)
virtproc=$(grep "^processor" /proc/cpuinfo | wc -l)
ram_free=$(free -m | grep Mem | awk '{print $4}')
ram_total=$(free -m | grep Mem | awk '{print $2}')
ram_usage_percent=$(free -m | grep Mem | awk '{printf("%.2f"), $3/$2*100}')
free_disk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{fdisk += $4} END {print fdisk}')
total_disk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{tdisk += $2} END {print tdisk}')
disk_usage_percent=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{fdisk += $3} {tdisk += $2} END {printf("%.2f"), fdisk/tdisk*100}')
proc_usage_percent=$(top -bn1 | grep '^%Cpu' | awk '{printf("%.1f%%"), $2}')
last_boot=$(who -b | awk '{print $3 " " $4}')
lvm_active=$(lsblk | grep 'lvm' | awk '{if ($1) {printf "\033[0;32mYes\033[0m";exit} else {print "\033[0;031mNo\033[0m";exit;}}')
n_active_connect=$(ss -t | grep ESTAB | wc -l)
n_users_server=$(who | cut -d " " -f 1 | sort -u | wc -l)
ipv4=$(hostname -I)
mac=$(ip link show | grep ether | awk '{print $2}')
n_commands_sudo=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall "  #Architecture: $arch
        #CPU physical: $phyproc
        #vCPU: $virtproc
        #Memory Free: ${ram_free}MB/${ram_total}MB ($ram_usage_percent%)
        #Disk Free: ${free_disk}MB/${total_disk}GB ($disk_usage_percent%)
        #CPU load: $proc_usage_percent
        #Last boot: $last_boot
        #LVM use: $lvm_active
        #Connections TCP: $n_active_connect ESTABLISHED
        #User log: $n_users_server
        #Network: IP $ipv4 ($mac)
        #Sudo: $n_commands_sudo cmd"
