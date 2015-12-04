#!/bin/sh
# Welcome Message
# @bdereims

ExtIP="<unset>"
Waiter=1
while [ $ExtIP = "<unset>" ]
do
	ExtIP=$(vim-cmd vmsvc/get.guest $(vim-cmd vmsvc/getallvms | grep "vPodRouter" | awk '{print $1}') | grep -m 1 "ipAddress" | sed -e 's/^.*=//' -e 's/[",\ ,\,]//g')
	
	if [ $ExtIP != "<unset>" ]; then
		break 
	fi

	cp /vmfs/volumes/dsLocalESX01/welcome.wait /etc/vmware/welcome
	cat /vmfs/volumes/dsLocalESX01/wait.${Waiter} >> /etc/vmware/welcome
	kill $(ps | grep dcui | awk '{print $1}') 

	Waiter=$(expr ${Waiter} + 1 )
	if [ ${Waiter} -gt 6 ]; then
		Waiter=1
	fi

	sleep 1 
done

cp /vmfs/volumes/dsLocalESX01/welcome.orig /etc/vmware/welcome
sed 's/####/'$ExtIP'/' -i /etc/vmware/welcome
kill $(ps | grep dcui | awk '{print $1}')	

exit 0
