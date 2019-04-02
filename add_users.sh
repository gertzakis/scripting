#!/bin/bash
# Script to add sudo-privileged Users
# Users added with same username & password
# Tested on CentOS/RHEL/Fedora
#
# TODO, read users from file if input exists else use the list-var
# TODO, make it a little interactive if you like


# Users list
Users=("makis" "takis" "giorgos")


test1="makis"
test2="makis2"
test3=$test1' '$test2
#echo $test3


add_users(){
	# Print each user in new line
	echo "Print each user in new line"
	for user in ${Users[*]}; do
		echo "Adding user $user"
		useradd -mp $(openssl passwd -6 $user) $user
	done
}

add_users_group(){
	# Add users to group wheel
	echo "Adding users to sudo group"
	for user in ${Users[*]}; do
		echo "Adding $user to wheel group"
		usermod -aG wheel $user
	done
}


#add_users
#add_users_group

if [ -n "$1" ]; then
	echo $1
else
	echo $Users
fi

echo "Cheers!"



