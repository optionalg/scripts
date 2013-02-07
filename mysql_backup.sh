#!/bin/bash
# mysql_backup.sh
# Connects to a mysql server and runs mysqldump on all databases

# Options
DESTDIR="/root/mysql_backup"
USR="root"
PW="root_pw"
HOST="localhost"
RETENTION_DAYS=7

# Create the $DESTDIR if it doesn't already exist
[ ! -d $DESTDIR ] && mkdir $DESTDIR || :

# Populate all databases on the system
DATABASES=`/usr/bin/mysql -u $USR -h $HOST -p$PW -Bse 'show databases'`

# Run mysqldump against each database listed in $DATABASES
for db in $DATABASES; do
    datetime=`date +%Y%m%d_%H%M%S`
    /usr/bin/mysqldump --skip-lock-tables -u $USR -h $HOST -p$PW $db | \
        gzip -9 > ${DESTDIR}/${HOST}_${db}_${datetime}.sql.gz
    chmod 0600 ${DESTDIR}/${HOST}_${db}_${datetime}.sql.gz
done

# Remove any backups older than $RETENTION_DAYS
find $DESTDIR -type f -name "*.sql.gz" -mtime +$RETENTION_DAYS -exec rm -f {} \;

