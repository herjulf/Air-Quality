#set term pbm color small
#set terminal png x222222 xffffff  
#set term png
#set output "sens.png"
set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb"#000000" behind
set key textcolor rgb '#FFFFFF' 
#set terminal png font arial x000000

set terminal png enhanced

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

#set y2tics nomirror tc rgb "white"
set y2range [ 0 : 50 ] noreverse nowriteback
set y2tics 0, 5 
set  y2label "ºC"  textcolor rgb "white"

set ytics nomirror tc rgb "white"
set ytics 0, 10

set title "NO2 sensor evaluation/Kungsgatan, Uppsala\n\
Recorded by IEEE 802.15.4 WSN Monitoring System" tc rgb "white"

#set format x "%m%d"                      
set xdata time
set yrange [ 0 : 110 ] noreverse nowriteback
#set xrange [ "2012-02-19 00:00:00" : "2012-02-21 24:00:00"] 
#set xrange [ "2012-10-09 18:00:00" : ] 


set ylabel "µg/m^3"  textcolor rgb "white"

set border  lc rgb "white"

f10(x) = A_mean;

set xdata
stat "kth-slb-no2.dat" using 5  prefix "A";

set xdata time

plot \
"kth-slb-no2.dat" using 1:4       axes x1y2 title "Temp" with line ls 1, \
"slb-no2.dat" using 1:($4)    axes x1y1 title "NO2 SLB Ref" with line ls 2, \
"kth-slb-no2.dat" using 1:($5)    axes x1y1 title "NO2 KTH-sensor#4" with line ls 3, \
f10(x) title "NO2 KTH-sensor#4 Ave" with line ls 4;



