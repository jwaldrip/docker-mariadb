#!/bin/bash

# Check if the server is running and accepting mysql commands.
srv_ready?(){
  set -e
  mysql -uroot -e "show databases";
}

# Start Server
/usr/bin/mysqld_safe &> /dev/null &
mysqld_pid=$!

# Wait for server
while ! srv_ready? ; do printf '.' ; done

# Create Admin
echo "=> Creating MySQL user: '$MYSQL_USER' with password: '$MYSQL_PASS'"
mysql -uroot -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASS'"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION"

# Kill Server for Safe Measure
kill $mysql_pid
echo "=> Done!"
