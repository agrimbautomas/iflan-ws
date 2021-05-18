#!/bin/bash

HOST="some.host.co"
DATABASE="a_database"
USER="some_user"
PASSWORD="a_password"

FILENAME="iflan-$(date +%d-%m-%Y).sql"

rm ./$FILENAME

printf "\n== Creating dump file with name $FILENAME in proyect dir ./"
printf "\n== Running mysqldump -h"$HOST" -u"$USER" "$DATABASE" -p"$PASSWORD" > ./"$FILENAME" --column-statistics=0 --set-gtid-purged=OFF \n"
mysqldump -h"$HOST" -u"$USER" "$DATABASE" -p"$PASSWORD" > ./"$FILENAME" --column-statistics=0 --set-gtid-purged=OFF

printf "\n== Copying dump to iflan_db container"
docker cp ./"$FILENAME" iflan_db:/

printf "\n== Droping previous database"
docker exec -it iflan_ws bundle exec rails db:drop db:create DISABLE_DATABASE_ENVIRONMENT_CHECK=1

printf "\n== Clonning database"
docker exec -i iflan_db mysql -uroot -psinclair iflan_dev < $FILENAME

printf "\n== Removing dump $FILENAME"
rm ./$FILENAME

printf "\n== SUCCESSFUL MIGRATION!"