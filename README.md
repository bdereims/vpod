Download 2 Virtual Machines ready to launch within Fusion on Mac OS X:
https://blue-tale.mooo.com/owncloud/index.php/s/B6xnqb2lDqVoc5p

```
    ___ _____  __        ___         _    
   | __/ __\ \/ /   __ _| _ \___  __| |   
   | _|\__ \>  <    \ V /  _/ _ \/ _` |   
   |___|___/_/\_\    \_/|_| \___/\__,_|   
   for Demo and Lab | Primary node        
                                         
                
ESX @IP: {ip from Fusion}
Entrypoint @IP: {vPodRouter ip provided by Fusion and printed automatically}
Inside Network: 172.16.66.0/24
                
Put a static route on your box in order to reach the internal network:
Mac OS: route add -net 172.16.66.0/24 {vPodRouter ip}
Windows: route add 172.16.66.0 mask 255.255.255.0 {vPodRouter ip}
               
Gateway, DNS Server and NTP server: 172.16.66.1 (vPodRouter)
DHCP Server for 172.16.66.200 to 172.16.66.254
NFS Datastore: 172.16.66.1:/data
SNAT outside networking to access Internet
                
You should add the DNS Server in your resolv.conf or entries below in etc/hosts:
172.16.66.1 vpodrouter.vpod.local
172.16.66.2 vsca.vpod.local
172.16.66.3 esx01.vpod.local
172.16.66.4 esx02.vpod.local

Credentials:
vCenter -> administrator@vsphere.local / VMware1!
ESX -> root / VMware1!
vPodRouter -> vmware / VMware1! and root / VMware1!

If you're facing some DHCP issues with VM receiving IP from Fusion instead
of vPodRouter, you must disable Fusion's DHCP feature for the second NIC (often vmnet1).
More details how to do it: http://goo.gl/B7N0j9
                
                
bdereims@vmware.com | @bdereims | https://github.com/bdereims/vpod
```
