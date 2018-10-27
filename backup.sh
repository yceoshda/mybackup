#!/bin/sh

## Backup mysql DBs in containers

# checking password was provided
if [ -z $MYSQL_ROOT_PASSWORD ]
then
    echo "MYSQL_ROOT_PASSWORD env variable not found"
    exit 1
fi

# checking mysql service name was provided
if [ -z $MYSQL_SERVICE_NAME ]
then
    echo "MYSQL_SERVICE_NAME env variable not found"
    exit 1
fi

# checking schema is provided
if [ -z $MYSQL_SCHEMA ]
then
    echo "MYSQL_SCHEMA env variable not found"
    exit 1
fi

filename="/tmp/$(date +%Y%m%d%H%M%S)_${MYSQL_SCHEMA}.sql"

echo -e "[client]\nuser=root\npassword=${MYSQL_ROOT_PASSWORD}\nhost=${MYSQL_SERVICE_NAME}" > /tmp/my.cnf
mysqldump --defaults-extra-file=/tmp/my.cnf ${MYSQL_SCHEMA} > $filename

if [ $? -ne 0 ]
then
    echo "Error during backup"
    exit 1
fi

gzip $filename
chown mysqlbackup:mysqlbackup ${filename}.gz
mv "${filename}.gz" /backup
