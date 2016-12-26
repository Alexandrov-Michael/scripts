#!/bin/bash
#Backup proxmox-0 vms

mountpoint1="//backup-srv2/proxmox-0"
mountpoint2="/mnt/backup-srv2"
testmount1=$(mount | grep $mountpoint1)
testmount2=$(mount | grep $mountpoint2)
PROGNAME="$(pwd -P)/$(basename $0)"

function flg () {
	logger "$1"
	exit 1
}

if [ $# -eq 0 ]; then
        logger "PROBLEM: usage $PROGNAME params";
	exit 1
    else
	if [ -n "$testmount1" ]
	then
		if [ -n "$testmount2" ]
		then
			vzdump $@ --mailnotification always --quiet 1 --mailto pasys00@yandex.ru --mode snapshot --node proxmox-0 --compress lzo --storage backup-srv2   
		else   
        		logger "PROBLEM: $PROGNAME $mountpoint2 not mounting"
			exit 1
		fi
	else
		logger "PROBLEM: $PROGNAME $mountpoint1 not mounting"
		exit 1
	fi
fi
exit 0

