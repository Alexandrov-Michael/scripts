#!/bin/bash
#install zabbix agent debian 7

wget http://repo.zabbix.com/zabbix/2.0/debian/pool/main/z/zabbix-release/zabbix-release_2.0-1wheezy_all.deb
dpkg -i zabbix-release_2.0-1wheezy_all.deb
apt-get update
apt-get install zabbix-agent && usermod -a -G adm zabbix
