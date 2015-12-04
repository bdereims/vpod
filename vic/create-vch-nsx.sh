#!/bin/bash
# $1 : name of VCH
# $2 : the datastore

export PATH=$PATH:/opt/vmware/vic/bonneville

cd /opt/vmware/vic/bonneville
./install-linux -user=Administrator@vsphere.local -target=172.16.66.2 '-passwd=VMware1!' -name=$1 -datastore=$2 -datacenter=Datacenter -cluster=Cluster -ceip=disable -memoryMB=512 -externalNetwork=vPodNetwork -containerNetwork=vxw-dvs-21-virtualwire-3-sid-5001-Photon
