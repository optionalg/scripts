#!/bin/bash
# mysql_backup.sh
# Connects to a mysql server and runs mysqldump on all databases

DESTDIR="/root/mysql_backup"
USR="root"
PW="***"
HOST="localhost"
RETENTION_DAYS=7
DATABASES="db1 db2 mysql"

# Create the $DESTDIR if it doesn't already exist
[ ! -d $DESTDIR ] && mkdir $DESTDIR || :

# Run mysqldump against each database listed in $DATABASES
for db in $DATABASES; do
    DATETIME=`date +%Y%m%d_%H%M%S`
    mysqldump -u $USR -h $HOST -p$PW $db | gzip -9 > $DESTDIR/$HOST\_$db\_$DATETIME.sql.gz
    chmod 0600 $DESTDIR/$HOST\_$db\_$DATETIME.sql.gz
done

# Remove any backups older than $RETENTION_DAYS
find $DESTDIR -type f -name "*.dmp.gz" -mtime +$RETENTION_DAYS | xargs rm

