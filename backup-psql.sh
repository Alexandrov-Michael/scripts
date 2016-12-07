#!/bin/bash
# backup psql server bases
NDATE=`date +%Y-%m-%d_%H_%M_%S`

export PGPASSWORD="Aa12345678"
bases=('complex')
IP="172.16.65.35"
dirD="/home/michael/share/psql/psql"

for b in ${bases[@]}
do
	pg_dump -h $IP -p 5432 -U postgres $b | gzip > $dirD/$b.$NDATE.sql.gz
	ls -1r $dirD/* | grep $dirD  | grep $b | sed -n '10,$ p' | xargs rm -f {}
done

