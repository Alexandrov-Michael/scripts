#!/bin/bash
# Проверка на монтирование точек


mountpoint1="//backup-srv/share/webserverlinux on /mnt/mysql"
mountpoint2="//backup-srv/share/webserverlinux/www on /mnt/www"

mount1=$(mount | grep "$mountpoint1")
mount2=$(mount | grep "$mountpoint2")

if [ -n "$mount1" ]
then
	if [ -n "$mount2" ]
	then
		exit 0
	else
		mount -a
	fi
else
	mount -a
fi
