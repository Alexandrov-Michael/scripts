#!/bin/bash

mountpoint1="//1c/Logs"
testmount1=$(mount | grep $mountpoint1)
PROGNAME="$(pwd -P)/$(basename $0)"
mntdir="/mnt/1c"
hostn="1c"

mount -a
if [ -n "$testmount1" ]
then
	logstr=$(iconv -f UCS-2 -t utf-8 $mntdir/"$(ls -1r $mntdir | head -1)" | grep ERR | sed -e 's/ERR/PROBLEM $hostn/g')
	if [ -n "$logstr" ]
	then
		logger "$logstr"
		#echo "$logstr"
	fi
else
	logger "PROBLEM: $PROGNAME $mountpoint1 not mounting"	
	exit 1
fi
