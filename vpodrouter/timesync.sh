#!/bin/bash
# Time Sync without ntp but web from google.com
# @bdereims
# In: nothing
# Out: exit 0

PATH=$PATH:/usr/bin:/bin
date -s "$(wget -qSO- --max-redirect=0 216.58.211.78 2>&1 | grep Date: | cut -d' ' -f5-8)Z"

exit 0
