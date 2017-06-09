#set term pbm color small
#set terminal png color
set term png

#  Data file format
#  printf(" PM STD %4d %4d %4d", pm.s1, pm.s2_5, pm.s10);
#  printf(" ATM %4d  %4d  %4d ", pm.a1, pm.a2_5, pm.a10);
#  printf(" DB %4d %4d %4d %4d %4d %4d", pm.db0_3, pm.db0_5, pm.db1, pm.db2_5, pm.db5, pm.db10);
#  printf("\n");

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

#set y2tics nomirror
#set y2range [ 0 : 110 ] noreverse nowriteback
#set y2tics 5, 0.5 
set ytics nomirror

set title "GreenIoT Project. KTH/SICS PM prototype evaluation.\n\
1 hour Side-by-side SLB bomparision .\n\
Uppsala Kungsgatan, Sweden "

set xdata time
set yrange [ 0 : 30 ] noreverse nowriteback
set xrange [ "2017-06-08 17:00:00" : "2017-06-08 18:00:00"] 

#set y2label "Relative Humidity" 
set output "pms.png"

f10(x) = 25.79
f2_5(x) = 5.593

set ylabel "PTM STD" 
plot \
"kungsgatan-ua.dat" using 1:7     axes x1y1 title "PM1.0 (STD)" with line ls 2, \
"kungsgatan-ua.dat" using 1:8       axes x1y1 title "PM2.5 (STD) " with line ls 3, \
"kungsgatan-ua.dat" using 1:9       axes x1y1 title "PM10 (STD)" with line ls 1, \
 f2_5(x) title "SLB Average PM2.5", \
 f10(x) title "SLB Average PM10";

set ylabel "PTM ATM" 
set output "pma.png"
plot \
"kungsgatan-ua.dat" using 1:11     axes x1y1 title "PM1.0 (ATM)" with line ls 2, \
"kungsgatan-ua.dat" using 1:12       axes x1y1 title "PM2.5 (ATM)" with line ls 3, \
"kungsgatan-ua.dat" using 1:13       axes x1y1 title "PM10 (ATM)" with line ls 1, \
 f2_5(x) title "SLB Average PM2.5", \
 f10(x) title "SLB Average PM10";


set ylabel "Dust Bin" 
set yrange [ 0 : 3000 ] noreverse nowriteback
set output "db.png"
plot \
"kungsgatan-ua.dat" using 1:15     axes x1y1 title "DB 0.3" with line ls 2, \
"kungsgatan-ua.dat" using 1:16       axes x1y1 title "DB 0.5" with line ls 3, \
"kungsgatan-ua.dat" using 1:17       axes x1y1 title "DB 1" with line ls 4, \
"kungsgatan-ua.dat" using 1:18       axes x1y1 title "DB 2.5" with line ls 5, \
"kungsgatan-ua.dat" using 1:19       axes x1y1 title "DB 5" with line ls 6, \
"kungsgatan-ua.dat" using 1:20       axes x1y1 title "DB 10" with line ls 7;


########################## PM 2.5 #######################################
set yrange [ 0 : 20 ] noreverse nowriteback
set ylabel "PTM ATM" 
set output "pm2_5-analysies.png"

plot \
"kungsgatan-ua.dat" using 1:12 axes x1y1 title "PM2.5 (ATM)" with line ls 1, \
 f2_5(x) title "SLB Average PM2.5";

set xdata
set xrange [ 0 : 2000] 
stat "kungsgatan-ua.dat" using 8:12  prefix "A";

########################## PM 10 ####################################
set yrange [ 0 : 100 ] noreverse nowriteback
set ylabel "PTM ATM" 
set output "pm10-analysies.png"

set xdata time
set xrange [ "2017-06-08 17:00:00" : "2017-06-08 18:00:00"] 
plot \
"kungsgatan-ua.dat" using 1:13 axes x1y1 title "PM10 (ATM)" with line ls 1, \
"kungsgatan-ua.dat" using 1:($13)*4 axes x1y1 title "PM10 (ATM) Corrected" with line ls 1, \
 f10(x) title "SLB Average PM 10";

set xdata
set xrange [ 0 : 2000] 
stat "kungsgatan-ua.dat" using 9:13  prefix "A";
