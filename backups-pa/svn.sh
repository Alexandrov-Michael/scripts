#!/bin/bash
#Бэкап svn на посте

### Переменные

dirS="/mnt/post/svn"
fileD="/home/michael/share/SVN/svn-$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

### Проверка точек монтирования

mountpoint1="//post/svn"
mountpoint2="/mnt/post/svn"
testmount1=$(mount | grep $mountpoint1)
testmount2=$(mount | grep $mountpoint2)

### Программа

PROGNAME="$(pwd -P)/$(basename $0)"

function flg () {
        logger "$1"
        exit 1
}


mount -a
sleep 5s

logger "$PROGNAME Backup SVN is starting..."

if [ -n "$testmount1" ]
then
        if [ -n "$testmount2" ]
        then
		tar -czf $fileD -C $dirS || flg "PROBLEM: $PROGNAME backup SVN прерван по ошибке tar"
                logger "$PROGNAME SVN backup is complite corrent"
                mail -s "Backup SVN is complite" pasys00@yandex.ru <<< "Projets backup is complite corrent $(date)"
        else
                logger "PROBLEM: $PROGNAME $mountpoint2 not mounting"
                exit 1
        fi
else
        logger "PROBLEM: $PROGNAME $mountpoint1 not mounting"
        exit 1
fi

exit 0
