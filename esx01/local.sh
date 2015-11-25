#!/bin/sh
#/etc/rc.local.d/local.sh

# local configuration options

# Note: modify at your own risk!  If you do/use anything in this
# script that is not part of a stable API (relying on files to be in
# specific places, specific tools, specific output, etc) there is a
# possibility you will end up with a broken system after patching or
# upgrading.  Changes are not supported unless under direction of
# VMware support.

#Welcome Message
nohup /vmfs/volumes/dsLocalESX01/gen_welcome.sh & 

exit 0
