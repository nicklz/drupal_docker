#!/usr/bin/env bash



## MySQL 
echo "drop database websitename;" | mysql -uroot -h mysql
echo "create database websitename;" | mysql -uroot -h mysql



echo "SYNC DATABASE"
echo "=================="

mysql -u root -h mysql --password="" websitename < /var/www/dump.sql


echo "RUN DRUSH"
echo "=================="
cd /var/www/project/websitename/docroot/sites/default && drush upwd admin admin && drush cr && drush updb -y 

