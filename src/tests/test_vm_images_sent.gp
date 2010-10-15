#!/usr/bin/env gnuplot
reset
set terminal png

set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%d/%m"
set xlabel "Image with Last modification time"

set ytics ("1 kiB" 1024, "10 kiB" 10240, "100 kiB" 102400, "1 MiB" 1048576, "10 MiB" 10485760, "100 MiB" 104857600, "1 GiB" 1073741824, "5 GiB" 5368709120, "10 GiB" 10737418240)
set ylabel "Bytes sent"

set title "VM images, Bytes sent"
set grid

set logscale y
set style data linespoints

plot "/tmp/rsyncbench_results_test_vm_images.txt" \
using 1:4 title "Sent", \
"" using 1:5 title "Sent compressed"
