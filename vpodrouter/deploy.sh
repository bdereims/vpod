#!/bin/bash
# Deploy OVA from here
# @bdereims
# In: $1=OVA_File $2=Targeted_ESX $3=Datastore $4=PortGroup

ovftool -ds=$3 -nw=$4 -dm=thin $1 vi://$2
