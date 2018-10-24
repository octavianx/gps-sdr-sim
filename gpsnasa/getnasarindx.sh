#!/bin/bash
#ftp://cddis.gsfc.nasa.gov/pub/gps/data/daily
#  file:  brdc%d%d%d0.%Y%Yn.Z
#  Z zip file 
# fetch the GPS navigation : RINDEX file from nasa everday
# the Date will use the UTC time -12 hours 
# macOS sierra bash date, must support date -v feature to rewind the time
#    
# by  reinhard , 2017-10-01,  work for mobike GPS cordination Mock. 
# 


DATECMD="/bin/date -u -v -3H"
YEAR4=`$DATECMD +%Y`
TARGETSVR=cddis.gsfc.nasa.gov
TARGETPATH=/pub/gps/data/daily/$YEAR4/brdc
TARGETFILE=brdc`$DATECMD   +%j`0.`$DATECMD  +%y`n.Z

echo $TARGETPATH
echo $TARGETFILE
TARGETURL="ftp://$TARGETSVR$TARGETPATH/$TARGETFILE"

echo $TARGETURL
curl $TARGETURL -O
if [ ! -f  $TARGETFILE ]; then
    echo "File not found: $TARGETFILE "
else
    uncompress $TARGETFILE
    echo "File uncompressed: $TARGETFILE"
fi
