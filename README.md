![alt tag](http://blogs.vmware.com/vmworld/files/2015/08/CNA_logo-300x203.png) ![NSX](http://vlenzker.net/wp-content/uploads/2015/10/NSX.png)

#Main Purpose
Virtual Pod that demonstrates containers management in vSphere leveraging NSX for more flexibility and a better security.
Without impact on your existing environnement: easy to install, easy to play with it and easy to uninstall.

[Download 2 Virtual Machines ready to launch within Fusion on Mac OS X (should also work with Workstation and VirtualBox)](https://blue-tale.mooo.com/owncloud/index.php/s/B6xnqb2lDqVoc5p)

***Pre-requisites:***
- ESX01 / VM #1: 12Gb of Memory and 128Gb of Disk (Thin)
- ESX02 / VM #2: 8Gb of Memory and 40Gb of Disk (Thin)
- More memory to accept more worlkloads or for best performance
- Tested on Fusion 8.0 (Apple MacBook Pro 16Gb of Memory) and vSphere 6.0U1 (Intel NUC i5 16Gb of Memory) with success


***The logo:***
```
    ___ _____  __        ___         _    
   | __/ __\ \/ /   __ _| _ \___  __| |   
   | _|\__ \>  <    \ V /  _/ _ \/ _` |   
   |___|___/_/\_\    \_/|_| \___/\__,_|   
   for Demo and Lab         
```                                         


***VCSA Screenshot:***

![VCSA Screenshot](https://github.com/bdereims/vpod/blob/master/docs/VCSA%20vPod.png)

[And about Docker Adoption](https://www.datadoghq.com/docker-adoption/?utm_medium=social&utm_source=googleplus&utm_campaign=docker-2681022)

#Installation and Setup

***Wait at least 20' after lauching ESX VMs in order to see @IP of vPodRouter and to let VCSA a warm-up.***
***If you start up vRA/vRA-IaaS, wait more 15' to be sure that all systems are ready.***
In order to improve performance, I recommend to increase memory and CPU for VCSA (from 3Gb to 8Gb, from 1 vCPU to 2 vCPU).
Although, the environment is pretty responsive on my Mac MacBook Pro (i7 / 16Gb / 1To SSD).

###Memory Overcommitment
In order to start ESX with more memory, we need to activate this feature.
Create or modify the config file with:
```
prefvmx.minVmMemPct = 25
```

File location is respectively:
```
Fusion => /Library/Preferences/VMware\ Fusion/config
Workstation => C:\ProgramData\VMware\VMware Workstation\config.ini
```

***I don't recommend to enable this feature unless to accept very low performance due to the high usage of disk instead of memory.***
 
###Nested Env
Fusion configuration, verify if the VT-x/EPT is exposed:

![Fusion Configurqtion](https://github.com/bdereims/vpod/blob/master/docs/VT-x%20EPT%20Fusion.png)

Nested ESX, as a VM, in VCSA - without it VMs can't be started:

![ESX Configuration](https://github.com/bdereims/vpod/blob/master/docs/Expose%20Hardware%20Nested%20ESX.png)

Put a static route on your box in order to reach the internal network:
- The {vPodRouter IP} will be found on the ESX Console when vPodRouter VM is up and running.
- Mac OS: ```route add -net 172.16.66.0/24 {vPodRouter IP}```
- Windows: ```route add 172.16.66.0 mask 255.255.255.0 {vPodRouter IP}```
- Test your env with: ```ping 172.16.66.1``` (vPodRouter) and ```ping 172.16.66.2``` (VCSA)
- Gateway, DNS Server and NTP server: 172.16.66.1 (vPodRouter)
- vPodRouter is a DHCP Server for 172.16.66.200 to 172.16.66.254
- NFS Datastore: ```172.16.66.1:/data```
- SNAT outside network to access Internet
                
You should add the DNS Server in your resolv.conf or entries below in etc/hosts:
```
172.16.66.1 vpodrouter.vpod.local
172.16.66.2 vcsa.vpod.local
172.16.66.3 esx01.vpod.local
172.16.66.4 esx02.vpod.local
```

Credentials:
- vCenter -> ```administrator@vsphere.local / VMware1!```
- ESX -> ```root / VMware1!```
- vPodRouter -> ```vmware / VMware1!```
- NSX Manager -> ```admin / VMware1!``` and ```admin / VMware1!VMware1!``` for Controller and EdgeGW

VCSA URL -> https://vcsa.vpod.local

If you're facing some DHCP issues with VM receiving IP from Fusion instead
of vPodRouter, you must disable Fusion's DHCP feature for the second NIC (often vmnet1).
(More details how to do it)[http://goo.gl/B7N0j9]

#vSphere Integrated Containers
Quick and quite simple:
- start VIC VM trough vCenter
- login to VIC via SSH or console with ```root / VMware1!```
- create a new VCH with the script ```./create-vch.sh VCH01 dsLocalESX01``` found in ```/root```
- after creation you could enjoy a new container Host in setting ```export DOCKER_HOST=tcp://{VCH IP}:2376```
- delete VCH with ```./destroy-vch.sh VCH01 dsLocalESX01```

Some caveats:
- VCH creation from the GUI could not work due to unknown reasons
- VCH creation on the NFS Datastore (dsNFS) is possible but performance is low
- You could create VCH and leverage NSX but you must create IPSets for FW containers

#vRA 7, Yes already installed!
vRA URL: https://vra.vpod.local with ```administrator / VMware1!```
Demo Tenant: https://vra.vpod.local/vcac/org/demo with ```admin / VMware1!```

How to install GuGent:
- Donwload bits from https://vra.vpod.local:5480/installer/GuestAgentInstaller_x64.exe or https://vra.vpod.local:5480/installer/LinuxGuestAgentPkgs.zip
- Import IaaS Certificat in ```/usr/share/gugent``` with ```echo | openssl s_client -connect iaas.vpod.local:443 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > cert.pem```
- Execute in ```/usr/share/gugent``` this script ```installgugent.sh iaas.vpod.local:443 ssl```
- Copy this file from vRA Appliance on your Linux box which will be the template ``` /opt/vmware/share/htdocs/service/software/download/prepare_vra_template.sh``` 
- Execute the script locally, so you're ready to deploy app

***App Blueprint example and ready to demo:***
- MySQL admin credentials are: ```admin / changeme```
- App URL: ```https://{front_web_ip}:8443```
- PHPMyAdmin URL: ```http://{backend_db_ip}:8081/phpmyadmin```
- Design of Owncloud Blueprint composed by 2 Docker containers in 2 VMs
![BlueprintDesign](https://github.com/bdereims/vpod/blob/master/docs/blueprint-design.png)
- Managed Items in vRA
![BlueprintMachines](https://github.com/bdereims/vpod/blob/master/docs/blueprint-items.png)
- The Owncloud deployed, Up and Runnig!
![BlueprintMachines](https://github.com/bdereims/vpod/blob/master/docs/blueprint-owncloud.png)

bdereims@vmware.com | [@bdereims](https://twitter.com/bdereims) | https://github.com/bdereims/vpod

