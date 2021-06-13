# vdr-channels-conf-to-triax-sat-ip-xml

This script converts channels.conf (vdr format) to xml format for Sat>IP "TRIAX tss400" 

login password for TRIAX TSS 400 : satip_admin

Playlist upload is done on "Upnp Settings" card.


cd vdr-channels-conf-to-triax-sat-ip-xml-main/                                          //cd to DIR with script

chmod +x vdr2tss400xml.sh

touch chan_sat_ip.xml                                                                     //create empty "fake" file

dvbv5-scan -a 1 -F -I DVBV5 -O VDR -l EXTENDED -o channels.conf HotBird-13.0E.conf        //create channels.conf for conversion


./vdr2tss400xml.sh                                                                        //execute bash script

output file should be in current Dir named "chan_sat_ip.xml"                              //Playlist upload is done on "Upnp Settings" card.

                                                                                         
