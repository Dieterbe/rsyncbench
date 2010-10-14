#!/usr/bin/env gnuplot
reset
set terminal png

set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%d/%m"
set xlabel "Image with Last modification time"

set ylabel "Bytes sent"

set title "VM images, Bytes sent"
set grid

set logscale y
set style data linespoints

plot "/tmp/rsyncbench_results_test_vm_images.txt" \
using 1:4 title "Sent", \
"" using 1:5 title "Sent compressed"
