#!/bin/bash
# backup psql server bases
NDATE=`date +%Y-%m-%d_%H_%M_%S`

export PGPASSWORD="Qwer12345678"
bases=('db2')
IP="localhost"
dirD="/home/michael/backups"

for b in ${bases[@]}
do
	pg_dump -h $IP -p 5432 -U postgres $b | gzip > $dirD/$b.$NDATE.sql.gz
	ls -1r $dirD/* | grep $dirD  | grep $b | sed -n '10,$ p' | xargs rm -f {}
done

