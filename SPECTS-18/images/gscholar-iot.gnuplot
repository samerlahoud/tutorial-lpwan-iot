gnuplot -persist <<"EOF"
set terminal png size 800,500 enhanced font "Fira Sans,20"
set output 'gscholar-plot.png'

set yrange [0:300]
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 0.9
set xtics format ""
set grid ytics

plot "gscholar-iot.dat" using 2:xtic(1) title "LoRa",'' using 3 title "NB-IoT"
EOF