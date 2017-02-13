#!/bin/bash
# backup psql server bases
NDATE=`date +%Y-%m-%d_%H_%M_%S`

export PGPASSWORD="Qwer12345678"
bases=('db2')
IP="localhost"
dirD="/mnt/backups"
mountpoint1='//192.168.1.1/backups'
testmount1=$(mount | grep $mountpoint1)


if [ -n "$testmount1" ]
then
	for b in ${bases[@]}
	do
		pg_dump -h $IP -p 5432 -U postgres $b | gzip > $dirD/$b.$NDATE.sql.gz
		ls -1r $dirD/* | grep $dirD  | grep $b | sed -n '10,$ p' | xargs rm -f {}
	done
else
	logger "PROBLEM: $mountpoint1 not mounting"
	exit 1
fi

