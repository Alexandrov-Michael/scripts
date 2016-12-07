#!/bin/bash
#Backup Разработки on backup-srv2 in pa (files intremental)

dirs="/mnt/razrab"
dird="/data/razrab/latest"
dirdate="/data/razrab/razrab-$(date +%Y-%m-%d_%H-%M-%S)"
logfile="/data/razrab/rsync.log"
mountpoint1="//ns/Разработки-00"
mountpoint2="/dev/sda1"
testmount1=$(mount | grep $mountpoint1)
testmount2=$(mount | grep $mountpoint2)
PROGNAME="$(pwd -P)/$(basename $0)"

function flg () {
	logger "$1"
	exit 1
}

logger "$PROGNAME Backup razrab is starting..."

if [ -n "$testmount1" ]
then
	if [ -n "$testmount2" ]
	then   
		logger "$PROGNAME backup razrab rsync started..."
	        rsync --archive --delete --delete-excluded --exclude="*.lck" $dirs $dird &> $logfile || flg "PROBLEM: $PROGNAME backup razrab aborted with rsync error"
		logger "$PROGNAME backup razrab cp started..."
       		cp -rl $dird $dirdate || flg "PROBLEM: $PROGNAME cp aborted"
		logger "$PROGNAME razrab backup is complite corrent"
		mail -s "Backup razrab is complite" pasys00@yandex.ru <<< "Razrab backup is complite corrent $(date)"
	else   
        	logger "PROBLEM: $PROGNAME $mountpoint2 not mounting"
		exit 1
	fi
else
	logger "PROBLEM: $PROGNAME $mountpoint1 not mounting"
	exit 1
fi

exit 0
