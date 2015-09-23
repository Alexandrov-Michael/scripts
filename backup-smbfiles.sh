#!/bin/bash
#Backup PROJECTS on backup-srv2 in pa (files intremental)

dirs="/mnt/Projects"
dird="/data/Projects/latest"
dirdate="/data/Projects/projects-$(date +%Y-%m-%d_%H-%M-%S)"
logfile="/data/Projects/rsync.log"
mountpoint1="//ns/Проекты"
mountpoint2="/dev/sda1"
testmount1=$(mount | grep $mountpoint1)
testmount2=$(mount | grep $mountpoint2)
PROGNAME="$(pwd -P)/$(basename $0)"

logger "$PROGNAME Backup Projects is starting..."

if [ -n "$testmount1" ]
then
	if [ -n "$testmount2" ]
	then   
	        rsync --archive --delete --delete-excluded --exclude="*.lck" $dirs $dird &> $logfile || logger "PROBLEM: $PROGNAME backup projects stoped whith rsync errors" && exit 1
       		cp --archive --link $dird $dirdate || logger "PROBLEM: $PROGNAME cp aborted" && exit 1
		logger "INFO: $PROGNAME Backup Projects is complite"
	else   
        	logger "PROBLEM: $PROGNAME $mountpoint2 not mounting"
		exit 1
	fi
else
	logger "PROBLEM: $PROGNAME $mountpoint1 not mounting" && exit 1
fi

exit 0
