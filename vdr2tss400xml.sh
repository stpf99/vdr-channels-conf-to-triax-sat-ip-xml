#!/bin/bash

IP=
COUNT=10
EPAR=1
IFS=":"
rm chan_sat_ip.xml

echo "<?xml version="1.0" encoding="UTF-8"?><channelTable msys="DVB-S">" >> chan_sat_ip.xml


while read NAME FREQ PAR SRC SR VPID APID TPID CAID SID NID TID RID
do
    echo Name:$NAME Freq:$FREQ Par:$PAR Src:$SRC SR:$SR VPid:$VPID APid:$APID TPid:$TPID CAid:$CAID SID:$SID NID:$NID TID:$TID RID:$RID
#   Das Erste HD;ARD:11493:HC23M5O35P0S1:S19.2E:22000:5101=27:5102=deu@3,5103=mis@3;5106=deu@106:5104;5105=deu:0:10301:1:1019:0
    freq=$FREQ 
    sr=$SR
   echo $PAR | sed 's/\([A-Z]\)/\n\1/g' > par.txt
    while read P
    do
	if [ M$P != "M" ]
	then
	    KEY=`echo $P | sed 's/\([A-Z]\)/\1 /g' | awk '{print $1}'`
	    NUM=`echo $P | sed 's/\([A-Z]\)/\1 /g' | awk '{print $2}'`
#	    echo $KEY $NUM

	    case $KEY in
		H )
	    	  pol=h ;;
		V )
		  pol=v ;;
		O )
    		    ro=$NUM ;;
		M )
   #	    case $NUM in
	#		2 )
	#		mtype=QPSK ;;   
     #       		5 )
		#	mtype=8PSK ;;   
         #   		6 )
		#	mtype=16APSK ;; 
         #   		7 )
		#	mtype=32APSK ;; 
        #    		10 )
		#	mtype=VSB8 ;;   
         #   		11 )
		#	mtype=VSB16 ;;  
        #    		12 )
		#	mtype=DQPSK ;;  
        #    		16 )
		#	mtype=QAM16 ;;  
        #    		32 )
		#	mtype=QAM32 ;;
        #    		64 )
		#	mtype=QAM64 ;;  
        #    		128 )
		#	mtype=QAM128 ;; 
        #    		256 )
	#		mtype=QAM256 ;; 
	#	    esac
	#	    ;;
	#	S )
	#	    if [ $NUM == 0 ]
	#	    then
	#		msys=dvbs
	#	    else
	#		msys=dvbs2
	#	    fi 
	#	    ;;
	#	C )
	#	    fec=$NUM ;;

	    esac

	fi


    done<par.txt
    rm -f par.txt
if [ M$NAME == M ]
numer=$(("numer+1"))
    then
    echo "<channel number=\""$numer"\"><tuneType>DVB-S-AUTO</tuneType><visible>true</visible><type>tv</type><name>${NAME}</name><freq>${FREQ}</freq><pol>$pol</pol><sr>${SR}</sr><src>1</src><pids>${VPID},${APID}</pids></channel>" >> chan_sat_ip.xml
	continue
    fi

    echo Name:$NAME Freq:$FREQ Par:$PAR Src:$SRC SR:$SR VPid:$VPID APid:$APID TPid:$TPID CAid:$CAID SID:$SID NID:$NID TID:$TID RID:$RID
#   Das Erste HD;ARD:11493:HC23M5O35P0S1:S19.2E:22000:5101=27:5102=deu@3,5103=mis@3;5106=deu@106:5104;5105=deu:0:10301:1:1019:0
    freq=$FREQ 
    sr=$SR


#    case $SRC in
#	S19.2E )
#	    src=1 ;;
#	S13.0E )
#	    src=2 ;;
 #   esac
    

 

    pids=`echo "0,18,"$VPID";"$APID","$TPID | sed 's/[,;]/\n/g' | awk -F"=" '{print $1}' | awk '{if(NR>1)printf",%s",$1; else printf"%s",$1}END{printf"\n"}'` 
#    echo $APID | sed 's/[,;]/\n/g'

#    echo src=$src freq=$freq pol=$pol ro=$ro mtype=$mtype msys=$msys sr=$sr fec=$fec pids=$pids

    echo "$NAME http://${IP}/?src=$src\&freq=$freq\&pol=$pol\&ro=$ro\&mtype=$mtype\&msys=$msys\&sr=$sr\&fec=$fec\&pids=$pids"
#    echo "$NAME http://192.168.168.37/?src=$src&freq=$freq&pol=$pol&ro=$ro&mtype=$mtype&msys=$msys&sr=$sr&fec=$fec&pids=$pids"
#    echo "$NAME http://192.168.168.37/%3Fsrc=$src%26freq=$freq%26pol=$pol%26ro=$ro%26mtype=$mtype%26msys=$msys%26sr=$sr%26fec=$fec%26pids=$pids"
    SRC=I


#    PAR=`echo "S=1|P=1|F=HTTP|U=192.168.168.37/%3Fsrc=$src%26freq=$freq%26pol=$pol%26ro=$ro%26mtype=$mtype%26msys=$msys%26sr=$sr%26fec=$fec%26pids=$pids|A=80"`
#    PAR=`echo "S=1|P=1|F=HTTP|U=192.168.168.37/?src=$src&freq=$freq&pol=$pol&ro=$ro&mtype=$mtype&msys=$msys&sr=$sr&fec=$fec&pids=$pids|A=80"`
  PAR=`echo "S=1|P=1|F=CURL|U=http%3A//${IP}/?src=$src&freq=$freq&pol=$pol&ro=$ro&mtype=$mtype&msys=$msys&sr=$sr&fec=$fec&pids=$pids|A=$APAR"`
    FREQ=$COUNT
    N=0
    COUNT=`expr $COUNT + 10` 
    APAR=`expr $APAR + 1` 
#   echo ${NAME}:${FREQ}:${PAR}:${SRC}:${SR}:${VPID}:${APID}:${TPID}:${CAID}:${SID}:${NID}:${TID}:${RID} >> chan_iptv.conf


#exit
  
done<channels.conf
echo "</channelTable>" >> chan_sat_ip.xml
