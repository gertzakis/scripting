#!/bin/bash
# Script to add sudo-privileged Users
# Tested on CentOS/RHEL/Fedora


# Users list
Users=("makis" "takis" "giorgos")

add_users(){
	# Print each user in new line
	echo "Print each user in new line"
	for user in ${Users[*]}; do
		echo $user
		openssl passwd -6 $user
	done
}

add_users_group(){
	# Add users to group wheel
	echo "Adding users to sudo group"
	for user in ${Users[*]}; do
		echo $user
	done
}

add_users
add_users_group

echo "Cheers!"



