#!/bin/bash
# Generate sat telegram with specified location cordinates
# cordinates oblidged to GPS cordinate standard.
#
#[WGS-84]handan fengfeng 36.4242392135,114.2109695645
#[GJC-02]handan fengfeng 36.4242300000,114.2109600000   
#washington 38.905658,-77.0267500 -b 8
#WGS-84  ARCTICK Greatwall -62.218156,-58.961821

if [ $# -eq 0 ] ; then
    echo "Generate Satlliate Broadcasting Telegram Base on NASA data "
    echo "help:"
    echo "program  [cityname]"
    echo "supports  changsha,chengdu tianjin,nanjing,wenzhou" 
fi 

CORDOFCITY=""
INPUTCITY=$1

case $INPUTCITY  in
    "nanjing"|"nj" )    CORDOFCITY="-62.218156,-58.961821"
    ;;
    "changsha"|"cs" )   CORDOFCITY="28.2277800000,112.9388600000"
    ;;
    "chengdu"|"cd" )    CORDOFCITY="30.5702000000,104.0647600000"
    ;;
    "guangzhou"|"gz" )  CORDOFCITY="23.1290800000,113.2643600000"
    ;;
    "handdan"|"hd" )    CORDOFCITY="36.4242392135,114.2109695645"
    ;;
    "kunming"|"km" )    CORDOFCITY="24.8796600000,102.8332200000"
    ;;
    "qingdao"|"qd" )    CORDOFCITY="34.3412700000,108.9398400000"
    ;;
    "shanghai"|"sh" )   CORDOFCITY="31.2396900000,121.4997200000"
    ;;
    "shenzhen"|"sz" )   CORDOFCITY="22.5428600000,114.0595600000"
    ;;
    "tianjin"|"tj" )    CORDOFCITY="39.1366672021,117.2100419600"
    ;;
    "wenzhou"|"wz" )    CORDOFCITY="27.9949200000,120.6993900000"
    ;;
    "xian"|"xa" )       CORDOFCITY="34.3412700000,108.9398400000"
    ;;
    "washington"|"DC")   CORDOFCITY="38.905658,-77.0267500"
    ;;
    * )                 echo "Unsupported arguments, pls check help"
                        exit
                        ;;
esac

echo "Generating with $INPUTCITY  $CORDOFCITY  "
../gps-sdr-sim -e `ls -t brdc*.*n |head -1` -l $CORDOFCITY -b 8




#[WGS-84]handan fengfeng 36.4242392135,114.2109695645
#[GJC-02]handan fengfeng 36.4242300000,114.2109600000   
#washington 38.905658,-77.0267500 -b 8
#WGS-84  ARCTICK Greatwall -62.218156,-58.961821
