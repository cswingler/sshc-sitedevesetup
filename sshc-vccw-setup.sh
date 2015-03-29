#!/bin/bash

# This script initializes a vccw installation with a copy of content from
# sshchicago.org.

FS1='fs1.sshchicago.org'
FS1DIR=/fserv/sitedev

# Prompt the user for their sshc username
echo "Enter your sshchicago.org LDAP username: " 
read username

# Restore mysql database
echo "Copying prod mysql database..."
rsync $username@$FS1:$FS1DIR/wordpress.sql /tmp/
mysql -uroot -pwordpress wordpress < /tmp/wordpress.sql

# Restore wordpress data
echo "Copying prod wordpress data (this will take a while)..."
pushd /vagrant/www/wordpress/wp-content/uploads/
rsync --progress -vr $username@$FS1:$FS1DIR/uploads/* . 
popd
echo "All done!"
