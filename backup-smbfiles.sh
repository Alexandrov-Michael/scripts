#!/bin/bash
#Backup files intremental

dir-s="/mnt/Projects"
dir-d="/data/Projects/latest"
dir-date="projects-$(date +%Y-%m-%d_%H-%M-%S)"
mountpoint1="//ns/Проекты"
mountpoint2="/dev/sda1"
testmount1=$(mount | grep $mountpoint1)
testmount2=$(mount | grep $mountpoint2)
PROGNAME=$(basename $0)


if [ -n "$testmount1" ]
then
	if [ -n "$testmount2" ]
	then   
	        rsync --archive --delete --delete-excluded $dir-s $dir-d || logger "PROBLEM: $PROGNAME rsync aborted"
       		cp --archive --link $dir-d $dir-date || logger "PROBLEM: $PROGNAME cp aborted"
	else   
        	logger "PROBLEM: $PROGNAME $mountpoint2 not mounting"
	fi
else
	logger "PROBLEM: $PROGNAME $mountpoint1 not mounting"
fi

exit 0
