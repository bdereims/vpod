![alt tag](http://blogs.vmware.com/vmworld/files/2015/08/CNA_logo-300x203.png)

Download 2 Virtual Machines ready to launch within Fusion on Mac OS X:
https://blue-tale.mooo.com/owncloud/index.php/s/B6xnqb2lDqVoc5p

```
SHASUM (ESX01.ova) = 0a5c3e64e9faa0fce11923dcbbcb8ab16bdeeb9f
SHASUM (ESX02.ova) = 
```

Last Update: 2015 12 05 - 10:33 CET


***Wait at least 20' after lauching ESX VMs in order to see @IP of vPodRouter and to let VCSA a warm-up.***

```
    ___ _____  __        ___         _    
   | __/ __\ \/ /   __ _| _ \___  __| |   
   | _|\__ \>  <    \ V /  _/ _ \/ _` |   
   |___|___/_/\_\    \_/|_| \___/\__,_|   
   for Demo and Lab         
```                                         
                
Put a static route on your box in order to reach the internal network:
- The {vPodRouter IP} will be found on the ESX Console when vPodRouter VM is up and running.
- Mac OS: ```route add -net 172.16.66.0/24 {vPodRouter IP}```
- Windows: ```route add 172.16.66.0 mask 255.255.255.0 {vPodRouter IP}```
- Test your env with: ```ping 172.16.66.1``` (vPodRouter) and ```ping 172.16.66.2``` (VCSA)
- Gateway, DNS Server and NTP server: 172.16.66.1 (vPodRouter)
- DHCP Server for 172.16.66.200 to 172.16.66.254
- NFS Datastore: ```172.16.66.1:/data```
- SNAT outside networking to access Internet
                
You should add the DNS Server in your resolv.conf or entries below in etc/hosts:
```
172.16.66.1 vpodrouter.vpod.local
172.16.66.2 vsca.vpod.local
172.16.66.3 esx01.vpod.local
172.16.66.4 esx02.vpod.local
```

Credentials:
- vCenter -> administrator@vsphere.local / VMware1!
- ESX -> root / VMware1!
- vPodRouter -> vmware / VMware1! and root / VMware1!
- NSX Manager -> admin / VMware1! and admin / VMware1!VMware1! for Controller and EdgeGW

VCSA URL -> https://vcsa.vpod.local

If you're facing some DHCP issues with VM receiving IP from Fusion instead
of vPodRouter, you must disable Fusion's DHCP feature for the second NIC (often vmnet1).
(More details how to do it)[http://goo.gl/B7N0j9]
          
          
                
                
bdereims@vmware.com | [@bdereims](https://twitter.com/bdereims) | https://github.com/bdereims/vpod

