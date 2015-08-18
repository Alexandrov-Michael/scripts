#!/bin/bash
# Backup scripst for postgressql bases

bases=('pa-t' 'complex' 'pa-soft' 'pa-invest')
mountpoint="//backup-srv/share/psql"

mountdir="/mnt/psql/"
testmount=$(/bin/mount | grep $mountpoint)
datetime=$(/bin/date +%Y-%m-%d_%H-%M-%S)
PROGNAME=$(/usr/bin/basename $0)

if [ -n "$testmount" ]
then
	for b in ${bases[@]}
	do
		/usr/bin/pg_dump -U postgres $b | gzip1 > /mnt/psql/$b.$datetime.pgsql.gz || logger "zabbix:PROBLEM $0 PSQL backup cancel"
		ls -1r $mountdir | grep $b | sed -n '10,$ p' | xargs rm -f {} || logger "zabbix:PROBLEM $0 Rotate cancel"
	done
else
	logger "zabbix:PROBLEM $0 Folder PSQL not mounted" 
fi

exit 0
