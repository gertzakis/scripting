#!/bin/sh

MYSQL=/usr/bin/mysql
MYSQLDUMP=/usr/bin/mysqldump
MYSQLPASS='password'
DOCKEREXEC='docker exec mysql-server'

DATABASES="$($DOCKEREXEC $MYSQL -u root --password=$MYSQLPASS -e "SHOW DATABASES;")"
#DATABASES="$($DOCKEREXEC $MYSQL -u root --password=$MYSQLPASS -e "SHOW DATABASES;" 
#    | grep -Ev "(Database|information_schema|performance_schema)")"

for database in $DATABASES
do
	echo $database
	$DOCKEREXEC $MYSQLDUMP -u root --password=$MYSQLPASS $database > $database.backup.sql
    
done

echo 'All done!'
