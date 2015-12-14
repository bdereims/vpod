#!/bin/bash
# Time Synch for ESX remotely
# @bdereims
# In : nothing 
# Out : exit 0

PATH=$PATH:/usr/bin:/bin
GOOGLEIP="216.58.211.78"

# Update time from web Google page
ping -c 1 ${GOOGLEIP} 2>&1 > /dev/null
if [ $? != 0 ]; then
	echo "Impossible to reach internet in order to synchronise time..."
	exit 1	
else
	date -s "$(wget -qSO- --max-redirect=0 216.58.211.78 2>&1 | grep Date: | cut -d' ' -f5-8)Z" 2>&1 > /dev/null
fi

update_esx () {
	# $1 : the ESX to update

	# Time of the vPodRouter
	HERE=$(date -u +%Y%m%d%H%M)

	# Verifiy if it's reachable
	ping -c 1 ${1} 2>&1 > /dev/null
	if [ $? == 0 ]; then

		# Time of the destination
		THERE=$(ssh ${1} "date +%Y%m%d%H%M")

		# If different then update
		if [ ${HERE} != ${THERE} ]; then	
			echo "Update Time and Date of ${1}"
			ssh $1 "esxcli system time set -d ${DAY} -H ${HOUR} -m ${MINUTE} -M ${MONTH} -s ${SECOND} -y ${YEAR}"
		fi
	fi
}


YEAR=$(date -u +%Y)
MONTH=$(date -u +%m)
DAY=$(date -u +%d)
HOUR=$(date -u +%H)
MINUTE=$(date -u +%M)
SECOND=$(date -u +%S)

update_esx esx01
update_esx esx02

exit 0
