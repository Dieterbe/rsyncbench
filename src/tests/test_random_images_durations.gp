#!/usr/bin/env gnuplot
reset
set terminal png

set xlabel "File size (MiB)"

set ylabel "Duration in seconds"

set title "Random images, duration"
set grid

set style data linespoints

plot "/tmp/rsyncbench_results_test_random_images.txt" using 1:2 title "Sending from scratch duration", \
"" using 1:5 title "No-op duration", \
"" using 1:8 title "Appended 1MiB duration", \
"" using 1:11 title "prepended 1MiB duration", \
