#!/bin/bash
# update 1c server

distrib="/mnt/distrib"
lastdeb="$(ls -1 $distrib | grep deb | tail -1)"
lastlinux="$distrib/lastlinux"
mountpoint="/ns/Distrib/1c/distrib"
testmount=$(mount | grep $mountpoint)
PROGNAME="$(pwd -P)/$(basename $0)"
dpkggrep="1c-enterprise83-server"
current1c="$(dpkg -l | grep $dpkggrep | awk '{print($3)}' | head -1)"

function update1c {
	rm $lastlinux/*.deb
	tar xzf "$distrib/$lastdeb" -C "$lastlinux"
	last1c="$(ls $lastlinux | grep $dpkggrep | head -1 | grep $current1c)"
	if [ -n "$last1c" ]
	then
		logger "current 1c is match with distib"
	else
        	dpkg -i $lastlinux/*.deb
        	/etc/init.d/srv1cv83 stop
        	/home/michael/1c8_uni2patch_lin.bin /opt/1C/v8.3/i386/backbas.so
        	/etc/init.d/srv1cv83 start	
	fi
}

if [ -n "$testmount" ]
then
	update1c
else
	mount -a
	if [ -n "$testmount" ]
	then
		update1c
	else
        	logger "PROBLEM: $PROGNAME $mountpoint not mounting"
	fi
fi

exit 0
