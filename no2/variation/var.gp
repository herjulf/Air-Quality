#set term pbm color small
#set terminal png x222222 xffffff  
#set term png
#set output "sens.png"
set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb"#000000" behind
set key textcolor rgb '#FFFFFF' 
#set terminal png font arial x000000

set terminal svg enhanced

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
set style line 7 lt 1 lw 1 pt 3 linecolor rgb "gray"
set style line 8 lt 1 lw 1 pt 3 linecolor rgb "orange"

#set y2tics nomirror tc rgb "white"
set y2range [ 0 : 50 ] noreverse nowriteback
set y2tics 0, 5 
set  y2label "ºC"  textcolor rgb "white"

set ytics nomirror tc rgb "white"
set ytics 0, 10

set title "NO2-B43F three sensor evaluation/Sample variation side-by-side\n\
Recorded by IEEE 802.15.4 WSN Monitoring System" tc rgb "white"

#set format x "%m%d"                      
set xdata time
set yrange [ -30 : 110 ] noreverse nowriteback
#set xrange [ "2012-02-19 00:00:00" : "2012-02-21 24:00:00"] 
#set xrange [ "2012-10-09 18:00:00" : ] 


#set ylabel "µg/m^3/pbm"  textcolor rgb "white"
set ylabel "pbm"  textcolor rgb "white"
set border  lc rgb "white"

#f2(x) = A2_mean;

set xdata
stat "no2.dat" using 6  prefix "A2";
stat "no2.dat" using 7  prefix "A3";
stat "no2-2.dat" using 6  prefix "A4";

set xdata time

set label 1 gprintf("AVE #2 = %g", A2_mean) at 2, A2_mean

plot \
"no2.dat" using 1:4       axes x1y2 title "Temp. #2 #3 C" with line ls 2, \
"no2-2.dat" using 1:4       axes x1y2 title "Temp. #4 C" with line ls 8, \
"no2.dat" using 1:($5)    axes x1y2 title "VCC #2#3" with line ls 1, \
"no2-2.dat" using 1:($5)    axes x1y2 title "VCC #4" with line ls 7, \
"no2-2.dat" using 1:($6)    axes x1y1 title "NO2-04" with dot ls 4, \
"no2.dat" using 1:($6)    axes x1y1 title "NO2-02" with dot ls 5, \
"no2.dat" using 1:($7)    axes x1y1 title "NO2-03" with dot ls 6, \
A2_mean    axes x1y1 title gprintf("NO2-02 AVE=%5.1f",A2_mean) with line ls 6, \
A3_mean    axes x1y1 title gprintf("NO2-03 AVE=%5.1f",A3_mean) with line ls 5, \
A4_mean    axes x1y1 title gprintf("NO2-04 AVE=%5.1f",A4_mean) with line ls 4;

