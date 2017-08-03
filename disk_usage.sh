#!/bin/sh

# Script for find disk usage

printf "\n"
echo " ========== Disk Usage Script ========= "
echo "Disk Usage per system: "
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1}'
printf "\n\n"
echo " ====================================== "
