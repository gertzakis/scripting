#!/bin/bash
# Script to add sudo-privileged Users
# Tested on CentOS/RHEL/Fedora


# Users list
Users=("makis" "takis" "giorgos")

# Print each user in new line
echo "Print each user in new line"
for user in ${Users[*]}; do
	echo $user
done

echo "Cheers!"



