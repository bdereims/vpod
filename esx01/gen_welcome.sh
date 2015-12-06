#!/bin/sh
# Welcome Message
# @bdereims
# In: nothing
# Out: exit 0

ExtIP="<unset>"
Waiter=1
LOCDIR=/vmfs/volumes/dsLocalESX01
WELCOMEMSG=/etc/vmware/welcome

# Kill welcome screen to print updated message
killws () {
	kill $(ps | grep dcui | awk '{print $1}')
}

# Main loop
while [ $ExtIP = "<unset>" ]
do
	# Looking for vPodRouter @IP after starting up, vPodRouter VM is autostarted
	ExtIP=$(vim-cmd vmsvc/get.guest $(vim-cmd vmsvc/getallvms | grep "vPodRouter" | awk '{print $1}') | grep -m 1 "ipAddress" | sed -e 's/^.*=//' -e 's/[",\ ,\,]//g')
	
	# If it's started and @IP is discoveredm exit while loop
	if [ $ExtIP != "<unset>" ]; then
		break 
	fi

	# Update the welcome message with the current waiter
	cp ${LOCDIR}/welcome.wait ${WELCOMEMSG} 
	cat ${LOCDIR}/wait.${Waiter} >> ${WELCOMEMSG} 

	killws		

	# Go foward waiter...
	Waiter=$(expr ${Waiter} + 1 )
	if [ ${Waiter} -gt 4 ]; then
		Waiter=1
	fi

	sleep 1 
done

# Finally update welcome message with all details and discovered vPodRouter @IP
cp ${LOCDIR}/welcome.orig ${WELCOMEMSG} 
sed 's/####/'$ExtIP'/' -i ${WELCOMEMSG} 

killws

exit 0
