#!/bin/bash
# backup psql server bases
NDATE=`date +%Y-%m-%d_%H_%M_%S`

export PGPASSWORD="Qq12345678"
bases=('pa-t' 'complex' 'pa-soft' 'pa-invest')

for b in ${bases[@]}
do
	pg_dump -h psql -p 5432 -U postgres $b | gzip > /home/michael/share/psql/psql/$b.$NDATE.sql.gz
#	ls -1r $mountdir | grep $b | sed -n '10,$ p' | xargs rm -f {}
done

