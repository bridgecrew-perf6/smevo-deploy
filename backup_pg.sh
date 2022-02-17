#!/bin/bash
export PGUSERNAME=
export PGPASSWORD=
BACKUP_PATH=~/backup
DB_HOST=`sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' smevo_db_1`
mkdir -p $BACKUP_PATH
var=$(date +"%FORMAT_STRING")
now=$(date +"%m_%d_%Y")
#printf "%s\n" $now
today=$(date +"%Y-%m-%d")

pgdump -h $DBHOST smevo -Fc >$BACKUP_PATH/smevo-$today.dump