#!/usr/bin/env gnuplot
reset
type=system("echo $TYPE")
title=system("echo $TITLE")
set terminal png

set xlabel "File size (MiB)"

set ylabel "Duration in seconds"

set title title." images, duration"
set grid

set style data linespoints

plot "/tmp/rsyncbench_results_test_".type."_images.txt" using 1:2 title "Sending from scratch", \
"" using 1:5 title "No-op", \
"" using 1:8 title "Appended 1MiB", \
"" using 1:11 title "prepended 1MiB"
