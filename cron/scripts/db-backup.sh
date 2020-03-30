#!/bin/sh
echo "Start backup script"

TODAY=`date +"%d%b%Y%H%M"`

################################################################
################## Update below values  ########################

DB_BACKUP_PATH='/sync/dbbackup'
MYSQL_HOST='db'
MYSQL_PORT='3306'
MYSQL_USER='test'
MYSQL_PASSWORD='test'
DATABASE_NAME='testdb'
BACKUP_RETAIN_DAYS=7   ## Number of days to keep local backup copy

#################################################################

echo "Backup started for database - ${DATABASE_NAME}"

mysqldump -h ${MYSQL_HOST} \
                  -P ${MYSQL_PORT} \
                  -u ${MYSQL_USER} \
                  -p${MYSQL_PASSWORD} \
                  ${DATABASE_NAME} | gzip > ${DB_BACKUP_PATH}/${DATABASE_NAME}-${TODAY}.sql.gz

if [ $? -eq 0 ]; then
  echo "Database backup successfully completed"
else
  echo "Error found during backup"
fi

echo "Init Delete old backups, keep only last ${BACKUP_RETAIN_DAYS} days."
find ${DB_BACKUP_PATH} -mtime +${BACKUP_RETAIN_DAYS} -type f -delete
echo "Completed"