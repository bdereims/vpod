#!/bin/sh
# Synch Time with google.con from web page not ntp

date -s "$(wget -qSO- --max-redirect=0 google.com 2>&1 | grep Date: | cut -d' ' -f5-8)Z"
