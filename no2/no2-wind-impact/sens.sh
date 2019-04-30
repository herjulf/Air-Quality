#!/bin/bash
# 121208 --ro

# ARG-1 ID 
# ARG-2 to tail 
# ARG-3 Filname

PTH=./
WEB=./
DATA=./sensors.dat
TMP=/tmp/sens.dat
DEST=./

function plot()
{
# cd /tmp
#tail -$1 $DATA  >  $TMP
 gnuplot < $PLOT > $DEST/$1
}

function remove_temp()
{
 rm -r $TMP
}

##  Do NO2 plot if needed
#-------------------------------
if [ NO2 == $1 ]; then
TMP=./no2.dat
 cat $DATA | grep "NO2 " | grep ^20 | tail -$2 | seltag -sel TXT=%s NO2_T=%s V_IN=%s NO2_PPB[2]=%s NO2_PPB[3]=%s  RSSI=%s > $TMP
TMP=./no2-2.dat
export $1="NO2\-2"
 cat $DATA | grep "NO2-2" | grep ^20 | tail -$2 | seltag -sel TXT=%s NO2_T=%s V_IN=%s NO2_PPB[4]=%s  RSSI=%s > $TMP
 #PLOT=./sens-no2.gp
 PLOT=./no2-wind.gp
plot   $3
fi

#remove_temp


