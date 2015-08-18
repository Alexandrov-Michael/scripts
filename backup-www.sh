#!/bin/bash
# Backup scripst for apache2 data

www="var/www"
mountpoint="//backup-srv/share/webserverlinux/www"

mountdir="/mnt/www"
testmount=$(mount | grep $mountpoint)
datetime=$(date +%Y-%m-%d_%H-%M-%S)
PROGNAME=$(basename $0)

function error_exit {
  echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
  exit 1
}

if [ -n "$testmount" ]
then
		tar czf $mountdir/www.$datetime.tar.gz -C / $www
		ls -1r $mountdir | sed -n '10,$ p' | xargs rm -f {}
else
	error_exit "$datetime: Folder WWW not mounted"
fi

exit 0
