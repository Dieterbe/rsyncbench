#!/usr/bin/env gnuplot
reset
set terminal png

set xlabel "File size (MiB)"

set ylabel "kiB sent"

set title "Random images, kiB transferred"
set grid

set style data linespoints

plot "/tmp/rsyncbench_results_test_random_images.txt" \
"" using 1:3 title "Sending from scratch kiB sent", \
"" using 1:4 title "Sending from scratch kiB sent compressed", \
"" using 1:6 title "No-op kiB sent", \
"" using 1:7 title "No-op kiB sent compressed", \
"" using 1:9 title "Appended 1MiB sent", \
"" using 1:10 title "Appended 1MiB sent compresed", \
"" using 1:12 title "Prepended 1MiB sent", \
"" using 1:13 title "Prepended 1MiB sent compresed"
