#!/bin/sh

# Script for find disk usage

echo -e "\n"
echo " ========== Disk Usage Script ========= "
echo "Disk Usage per system: "
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1}'
echo -e "\n\n"
echo " ====================================== "
