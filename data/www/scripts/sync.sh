#!/usr/bin/env bash



## MySQL 
echo "drop database websitename;" | mysql -uroot -h mysql
echo "create database websitename;" | mysql -uroot -h mysql



echo "SYNC DATABASE"
echo "=================="

#drush @fh-cin-pp.dev sql-dump | mysql -u root -h mysql -p cin --password=""
#mysqldump -u root -h mysql --password=""  cin > /var/www/dump.sql
mysql -u root -h mysql --password="" websitename < /var/www/dump.sql


echo "RUN DRUSH"
echo "=================="
cd /var/www/project/websitename/docroot/sites/default && drush upwd admin admin && drush cr && drush updb -y 
cd /var/www/project/websitename/docroot/sites/default && drush fr websitename_resources -y && drush cr 
