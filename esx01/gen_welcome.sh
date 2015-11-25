#!/bin/sh
#Welcome Message                                                                                                                                                                                                        

ExtIP="<unset>"
while [ $ExtIP = "<unset>" ]
do
	echo "Retreiving IP of vPodRouter..."
	ExtIP=$(vim-cmd vmsvc/get.guest $(vim-cmd vmsvc/getallvms | grep "vPodRouter" | awk '{print $1}') | grep -m 1 "ipAddress" | sed -e 's/^.*=//' -e 's/[",\ ,\,]//g')
	cp /vmfs/volumes/dsLocalESX01/welcome.orig /etc/vmware/welcome
	sed 's/####/'$ExtIP'/' -i /etc/vmware/welcome
	kill $(ps | grep dcui | awk '{print $1}')	
	sleep 3 
done

exit 0
