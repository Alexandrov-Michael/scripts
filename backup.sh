#/bin/bash
# Backup scripst for postgressql bases

bases=('pa-t' 'complex' 'pa-soft' 'pa-invest')
mountpoint="//backup-srv/share/psql"

testmount=$(/bin/mount | grep $mountpoint)
datetime=$(/bin/date +%Y-%m-%d_%H-%M-%S)
PROGNAME=$(/usr/bin/basename $0)

function error_exit {
  echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
  exit 1
}

if [ -n "$testmount" ]
then
	for b in ${bases[@]}
	do
		/usr/bin/pg_dump -U postgres $b | /bin/gzip > /mnt/psql/$b.$datetime.pgsql.gz
	done
else
	error_exit "Folder PSQL not mounted"
fi

exit 0
