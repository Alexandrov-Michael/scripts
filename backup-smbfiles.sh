#!/bin/bash
#Backup files intremental

dir-s="/mnt/Projects"
dir-d="/data/Projects/latest"
dir-date="projects-$(date +%Y-%m-%d_%H-%M-%S)"
mountpoint="//ns/Проекты"
testmount=$(mount | grep $mountpoint)
PROGNAME=$(basename $0)


if [ -n "$testmount" ]
then
	rsync --archive --delete --delete-excluded $dir-s $dir-d || logger "PROBLEM: $PROGNAME rsync aborted"
	cp --archive --link $dir-d $dir-date || logger "PROBLEM: $PROGNAME cp aborted"
else
	logger "PROBLEM: $PROGNAME $mountpoint not mounting"
fi

exit 0
