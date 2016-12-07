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

function flg () {
	logger "$1"
	exit 1
}

logger "$PROGNAME Backup Projects is starting..."

if [ -n "$testmount1" ]
then
	if [ -n "$testmount2" ]
	then   
		logger "$PROGNAME backup projects rsync started..."
	        rsync --archive --delete --delete-excluded --exclude="*.lck" $dirs $dird &> $logfile || flg "PROBLEM: $PROGNAME backup projects aborted with rsync error"
		logger "$PROGNAME backup projects cp started..."
       		cp -rl $dird $dirdate || flg "PROBLEM: $PROGNAME cp aborted"
		logger "$PROGNAME Projets backup is complite corrent"
		mail -s "Backup Projects is complite" pasys00@yandex.ru <<< "Projets backup is complite corrent $(date)"
		find /data/Projects/* -maxdepth 0 -type d -iname "projects-*" | sort -r | sed -n '370,$ p' | xargs rm -rf {}
	else   
        	logger "PROBLEM: $PROGNAME $mountpoint2 not mounting"
		exit 1
	fi
else
	logger "PROBLEM: $PROGNAME $mountpoint1 not mounting"
	exit 1
fi

exit 0
