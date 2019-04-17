#!/bin/bash
# 121208 --ro

# ARG-1 ID 
# ARG-2 to tail 
# ARG-3 Filname

PTH=/usr/local/scripts
WEB=/www/www.herjulf.net/projects/sensor/environmental
DATA=/var/log/sensors.dat
DATA=./slb-KTH.dat
TMP=/tmp/sens.dat
DEST=/var/www/www.herjulf.net/projects/sensor/environmental
SELTAG=/usr/local/bin/seltag

function plot()
{
 cd /tmp
#tail -$1 $DATA  >  $TMP
 /opt/gnuplot/bin/gnuplot < $PLOT > $DEST/$1
}

function remove_temp()
{
 rm -r $TMP
}

##  Do NO2 plot if needed
#-------------------------------
if [ NO2-2 == $1 ]; then
TMP=/tmp/no2.dat
 cat $DATA | grep $1 | grep ^20 | tail -$2 | $SELTAG -sel TXT=%s T_SHT2X=%s NO2_UG4=%s  > $TMP
#PLOT=/usr/local/scripts/sens-no2.gp
#plot   $3
fi

##  Do apple tree plot if needed
#-------------------------------
if [ 00031 == $1 ]; then
TMP=/tmp/tree.dat
 cat $DATA | grep $1 | grep ^20 | tail -$2 | $SELTAG -sel ID=%s T=%s RH=%s V_MCU=%s V_IN=%s RSSI=%s > $TMP
PLOT=/usr/local/scripts/sens-tree.gp
plot   $3
fi

##  Do moisture plot if needed
#-----------------------------
if [ 000d5 == $1 ]; then
   cat $DATA | grep $1 | grep ^20 | tail -$2 | /sbin/seltag 2 T=%s RH=%s V_MCU=%s V_A1=%s  | grep -v Miss | vh400 5 > $TMP

PLOT=/usr/local/scripts/sens-moisture.gp
plot   $3
fi

##  Do battery plot if needed
#----------------------------
if [ 0004a == $1 ]; then
  cat $DATA | grep $1 | grep ^20 | tail -$2 | /sbin/seltag 2 ID=%s T=%s V_IN=%s RSSI=%s > $TMP

PLOT=/usr/local/scripts/sens-bat.gp
plot   UPS-battery-$3
fi

##  Do barometer plot if needed
#-------------------------------
if [ 00093 == $1 ]; then
TMP=/tmp/barometer.dat
 cat $DATA | grep $1 | grep ^20 | tail -$2 | /sbin/seltag 2 ID=%s T=%s P=%s V_MCU=%s V_IN=%s RSSI=%s > $TMP
PLOT=/usr/local/scripts/barometer.gp
plot   $3
fi

##  Do cap plot if needed
#------------------------
if [ 00047 == $1 ]; then
   cat $DATA | grep $1 | grep ^20 | tail -$2 | /sbin/seltag 2 ID=%s V_IN=%s V_MCU=%s > $TMP

PLOT=/usr/local/scripts/sens-cap.gp
plot   $3
fi

##  Do AC main power plot if needed
#----------------------------------
if [ 0007f == $1 ]; then
TMP=/tmp/main-AC-power.dat
  cat $DATA | grep $1 | grep ^20 | tail -$2 |  /sbin/seltag 2 ID=%s T=%s RSSI=%s P0=%s P0_T=%s  P1=%s P1_T=%s  > $TMP

PLOT=/usr/local/scripts/main-AC-power.gp
plot   $3
fi

##  Do pyranometer plot if needed
#-------------------------------
if [ 000c6 == $1 ]; then
TMP=/tmp/pyranometer.dat
 cat $DATA | grep $1 | grep ^20 | tail -$2 | /sbin/seltag 2 ID=%s V_MCU=%s V_A1=%s V_A2=%s > $TMP
PLOT=/usr/local/scripts/pyranometer.gp
plot   $3
fi

##  Do supercapacitor plot if needed
#-------------------------------
if [ 0003e == $1 ]; then
TMP=/tmp/cap.dat
 cat $DATA | grep $1 | grep ^20 | tail -$2 | /sbin/seltag 2 ID=%s V_MCU=%s V_A1=%s V_A2=%s > $TMP

TMP=/tmp/pmeter.dat
 cat $DATA | grep 00c6 | grep ^20 | tail -$2 | /sbin/seltag 2 ID=%s V_MCU=%s V_A1=%s V_A2=%s > $TMP
PLOT=/usr/local/scripts/sens-cap.gp
plot   $3
fi


##  Do VREG plot if needed
#-------------------------------
if [ 0037da == $1 ]; then
TMP=/tmp/vregcap270f.dat
 cat $DATA | grep $1 | grep ^20 | tail -$2 | /sbin/seltag 2  V_MCU=%s V_IN=%s > $TMP
PLOT=/usr/local/scripts/vregcap270f.gp
plot   $3
fi


#remove_temp


