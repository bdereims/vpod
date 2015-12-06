ovftool -ds=dsLocalESX02 -nw=vPodNetwork -dm=thin \
--acceptAllEulas \
--prop:"varoot-password"="VMware1!" \
--prop:"va-ssh-enabled"="1" \
--prop:"vami.hostname"="vra.vpod.local" \
--prop:"vami.gateway.VMware_vRealize_Appliance"="172.16.66.1" \
--prop:"vami.domain.VMware_vRealize_Appliance"="vpod.local" \
--prop:"vami.searchpath.VMware_vRealize_Appliance"="vpod.local" \
--prop:"vami.DNS.VMware_vRealize_Appliance"="172.16.66.1" \
--prop:"vami.ip0.VMware_vRealize_Appliance"="172.16.66.12" \
--prop:"vami.netmask0.VMware_vRealize_Appliance"="255.255.255.0255.255.255.0" \
--net:"Network 1"="vPodNetwork" \
VMware-vR-Appliance-7.0.0.1360-3244232_OVF10.ova \
vi://esx02
