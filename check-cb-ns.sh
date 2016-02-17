#!/bin/bash

mountpoint1="//ns/Logs"
testmount1=$(mount | grep $mountpoint1)
PROGNAME="$(pwd -P)/$(basename $0)"

mount -a
if [ -n "$testmount1" ]
then
	logstr=$(iconv -f UCS-2 -t utf-8 /mnt/ns/"$(ls -1r /mnt/ns | head -1)" | grep ERR | sed -e 's/ERR/PROBLEM NS/g')
	if [ -n "$logstr" ]
	then
		logger "$logstr"
		#echo "$logstr"
	fi
else
	logger "PROBLEM: $PROGNAME $mountpoint1 not mounting"	
	exit 1
fi
