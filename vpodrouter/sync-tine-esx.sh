#!/bin/bash
# Time Synch for ESX remotely
# @bdereims
# In : N/A
# Out : exit 0

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
