#!/bin/bash
# Backup scripst for mysql bases

mountpoint="//backup-srv/share/webserverlinux"
bases=('mantis' 'mediawiki')

mountdir="/mnt/mysql"
testmount=$(mount | grep $mountpoint)
datetime=$(date +%Y-%m-%d_%H-%M-%S)
PROGNAME=$(basename $0)

function error_exit {
  echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
  exit 1
}

if [ -n "$testmount" ]
then
	for b in ${bases[@]}
        do
		mysqldump $b | /bin/gzip > $mountdir/$b.$datetime.mysql.gz
                ls -1r $mountdir | grep $b | sed -n '10,$ p' | xargs rm -f {}
        done
else
	error_exit "$datetime: Folder Mysql not mounted"
fi

exit 0
