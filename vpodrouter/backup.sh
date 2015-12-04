#!/bin/bash

cd /
tar cvzf /data/vpod/vpodrouter/vpod-conf.tgz etc/bind etc/dhcp etc/rc.local etc/sysctl.conf etc/network/interfaces etc/issue* etc/motd etc/ntp.conf
cd -
