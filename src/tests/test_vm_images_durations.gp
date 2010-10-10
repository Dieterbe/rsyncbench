#!/usr/bin/env gnuplot
reset
set terminal png

set xdata time
set timefmt "%d/%m/%Y %H:%M:%S"
set format x "%d/%m/%Y %H:%M:%S"
set xlabel "Image with Last modification time"

set ylabel "Duration in seconds"

set title "VM images, duration"
set grid

set style data linespoints

plot "/tmp/rsyncbench_results_test_vm_images.txt" using 1:3 title "Duration"
