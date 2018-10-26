INTRO

This is a generic project setup for Drupal 8 using rsync to improve docker file I/O performance. 

TODO: make a config file to replace all ccurrences of 'websitename'

SETUP
0. Install Docker (https://blog.jayway.com/2017/04/19/running-docker-on-bash-on-windows/)

1. git clone git@github.com:nicklz/drupal_docker.git
2. cd drupal_docker
3. cp ~/.ssh/id_rsa data/www/id_rsa (place a copy of the database called 'dump.sql' in data/www/dump.sql as well)
4. docker-compose up -d
5. docker exec -it websitename_web bash
6. ./scripts/setup.sh 
7. Visit http://local.websitename.edu:20003

COMMANDS (within websitename_web)

./scripts/sync.sh = sync database

./scripts/restart.sh = run this any time after restarting 

Visit http://local.websitename.edu:20006 for phpmyadmin (root with no password)
