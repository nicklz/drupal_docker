#!/usr/bin/env bash

apt-get install inotify-tools rsync -y

cd / && mkdir /project

echo "BEGIN RSYNC"

while true ; do
  rsync -avz --delete --exclude node_modules --exclude .git /var/www/project/ /project
done


