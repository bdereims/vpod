#!/bin/bash
# Copy Welcome message to esx
# @bdereims
# In: nothing
# Out: exit 0

scp esx01/welcome.* esx01:/vmfs/volumes/dsLocalESX01/.
scp esx01/wait.* esx01:/vmfs/volumes/dsLocalESX01/.
scp esx01/gen_welcome.sh esx01:/vmfs/volumes/dsLocalESX01/.
ssh esx01 "/vmfs/volumes/dsLocalESX01/gen_welcome.sh"

ping -c 1 esx02 2>&1 > /dev/null
if [ $? != 0 ]; then
	echo "ESX02 is not here..."
	exit 1	
fi

scp esx02/welcome.orig esx02:/vmfs/volumes/dsLocalESX02/welcome.orig
ssh esx02 "/vmfs/volumes/dsLocalESX02/gen_welcome.sh"

exit 0
