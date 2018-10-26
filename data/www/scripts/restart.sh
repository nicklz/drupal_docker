#!/usr/bin/env bash

 apt-get install inotify-tools rsync -y

  cd / && mkdir /project

  #https://github.com/EugenMayer/docker-sync/wiki/docker-sync-on-Windows
  #while inotifywait  -r -e modify,create,delete  /var/www/project; do
  #	rsync -avz /var/www/project/ /project
  #done


  while true ; do
	    rsync -avz --delete --exclude node_modules --exclude .git /var/www/project/ /project
    done



    #rsync -avu --delete "/var/www/project/prism/docroot/" "/web/docroot"

