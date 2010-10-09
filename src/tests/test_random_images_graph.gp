#!/usr/bin/env gnuplot
reset
set terminal png

set xlabel "File size (MiB)"

set ylabel "Duration in seconds, kiB sent"

set title "Random images"
set key reverse Left outside
set grid

set style data linespoints

size scratch_d scratch_b_sent scratch_b_sent_comp noop_d noop_b_sent noop_b_sent_comp append_1_d append_1_b_sent append_1_b_sent_comp prepend_1_d prepend_1_b_sent prepend_1_b_sent_comp

plot "/tmp/rsyncbench_results_test_random_images.txt" using 1:2 title "Sending from scratch duration", \
"" using 1:3 title "Sending from scratch kiB sent", \
"" using 1:4 title "Sending from scratch kiB sent compressed", \
"" using 1:5 title "No-op duration", \
"" using 1:6 title "No-op kiB sent", \
"" using 1:7 title "No-op kiB sent compressed", \
"" using 1:8 title "Appended 1MiB duration", \
"" using 1:9 title "Appended 1MiB sent", \
"" using 1:10 title "Appended 1MiB sent compresed", \
"" using 1:11 title "prepended 1MiB duration", \
"" using 1:12 title "Prepended 1MiB sent", \
"" using 1:13 title "Prepended 1MiB sent compresed", \
