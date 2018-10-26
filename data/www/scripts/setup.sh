#!/usr/bin/env bash


## for composer

apt-get update
apt-get install sudo

useradd -m docker

usermod -G root docker

mkdir ~/.ssh
cp -rf /var/www/id_rsa ~/.ssh/id_rsa
chmod 400 ~/.ssh/id_rsa

mkdir /home/docker/.ssh
cp -rf /var/www/id_rsa /home/docker/.ssh/id_rsa
chmod 400 /home/docker/.ssh/id_rsa

ln -s /var/www ~/sites


## Pre add ssh keys
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
ssh-keyscan -H keys.gnupg.net >> ~/.ssh/known_hosts
ssh-keyscan -H raw.githubusercontent.com >> ~/.ssh/known_hosts
ssh-keyscan -H bitbucket.org  >> ~/.ssh/known_hosts
ssh-keyscan -H drush.in  >> ~/.ssh/known_hosts
ssh-keyscan -H git.websitename.org  >> ~/.ssh/known_hosts
ssh-keyscan -H websitename.org  >> ~/.ssh/known_hosts
ssh-keyscan -H ci-406-uceap-websitename.pantheonsite.io  >> ~/.ssh/known_hosts
ssh-keyscan -H pantheonsite.io  >> ~/.ssh/known_hosts
ssh-keyscan -H codeserver.dev.124a2a40-4bd3-440e-950c-e2302f8952bf.drush.in  >> ~/.ssh/known_hosts
ssh-keyscan -H codeserver.dev.8fe0448e-b1c0-43d5-9aee-2876644b7c7e.drush.in:2222  >> ~/.ssh/known_hosts






echo "GIT === "
echo "=========="

rm -rf /var/www/project
mkdir /var/www/project



rm -rf /tmp/websitename
cd /tmp && git clone git@github.com:nicklz/websitename.git websitename && cd websitename && composer install
mv /tmp/websitename /var/www/project/websitename






#cp -rf /var/www/local.websitename.com  /var/www/project/websitename/docroot/sites/
cp -rf /var/www/local.websitename.com/settings.php  /var/www/project/websitename/docroot/sites/default/settings.local.php

cp -rf /var/www/files  /var/www/project/websitename/docroot/sites/default/
cp -rf /var/www/.drush  /root/
cp -rf /var/www/.acquia  /root/



## MySQL
echo "drop database websitename;" | mysql -uroot -h mysql
echo "create database websitename;" | mysql -uroot -h mysql




echo "SYNC DATABASE"
echo "=================="

mysql -u root -h mysql -p websitename --password="" < /var/www/dump.sql



echo "DRUPAL UPDATE === "
echo "=========="
cd /var/www/project/websitename/docroot/sites/default && drush updb -y
cd /var/www/project/websitename/docroot/sites/default && drush cr -y
#cd /var/www/project/websitename/docroot/sites/default && drush cim

/var/www/scripts/restart.sh &
