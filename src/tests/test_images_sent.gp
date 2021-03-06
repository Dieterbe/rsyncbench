#!/usr/bin/env gnuplot
reset
type=system("echo $TYPE")
title=system("echo $TITLE")

set terminal png

set xlabel "File size (MiB)"
set ytics ("1 kiB" 1024, "1 MiB" 1048576, "10 MiB" 10485760, "100 MiB" 104857600, "1 GiB" 1073741824)
set ylabel "Bytes sent"

set title title." images, bytes transferred"
set grid

set logscale y
set style data linespoints

plot "/tmp/rsyncbench_results_test_".type."_images.txt" \
using 1:3 title "Sending from scratch", \
"" using 1:4 title "Sending from scratch compressed", \
"" using 1:6 title "No-op", \
"" using 1:7 title "No-op  compressed", \
"" using 1:9 title "Appended 1MiB", \
"" using 1:10 title "Appended 1MiB compresed", \
"" using 1:12 title "Prepended 1MiB", \
"" using 1:13 title "Prepended 1MiB compresed"
