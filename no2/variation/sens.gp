#set term pbm color small
set terminal png x222222 xffffff  
#set term png
#set output "sens.png"

set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%y%m%d\n%H:%M"                      
#set format x "%y%m%d"
#set format x  "%d/%m"
set datafile missing "85.00"
#set time


set style line 1 lt 1 lw 1 pt 3 linecolor rgb "red"
set style line 2 lt 1 lw 1 pt 3 linecolor rgb "blue"
set style line 3 lt 1 lw 1 pt 3 linecolor rgb "green"
set style line 4 lt 1 lw 1 pt 3 linecolor rgb "yellow"
set style line 5 lt 1 lw 1 pt 3 linecolor rgb "brown"
set style line 6 lt 1 lw 1 pt 3 linecolor rgb "white"

set y2tics nomirror
set y2range [ 0 : 110 ] noreverse nowriteback
#set y2tics 5, 0.5 
set ytics nomirror

set title "Measurements in apple tree @ 2.5 meter Hagundagatan, Uppsala\n\
Recorded by IEEE 802.15.4 Wireless Sensor Monitoring System"

#set format x "%m%d"                      
set xdata time
set yrange [ -20 : 40 ] noreverse nowriteback
#set xrange [ "2012-02-19 00:00:00" : "2012-02-21 24:00:00"] 

set y2label "Relative Humidity" 


plot \
"sens.dat" using 1:8     axes x1y1 title "Radio Signal Strength Ind. RSSI" with line ls 2, \
"sens.dat" using 1:($6)*10 axes x1y1 title "MCU. Volt * 10" with line ls 3, \
"sens.dat" using 1:($5)    axes x1y2 title "Rel. Humidity.  % " with line ls 4, \
"sens.dat" using 1:4       axes x1y1 title "Temp. Celcius" with line ls 1;

