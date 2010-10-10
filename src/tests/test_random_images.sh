#!/bin/sh

function test_run () {
	> /tmp/rsyncbench_results_test_random_images.txt
	for size in 1 100 1024
	do
		line="$size "
		rm -rf $src/*
		rsync -a $src/ $dst/
		cp $pool/data-random-$size $src
		# from scratch
		measure_rsync
		line="$line $duration $kiB_sent $kiB_sent_comp"
		# no-op
		measure_rsync
		line="$line $duration $kiB_sent $kiB_sent_comp"
		# append random data block
		cat $pool/data-random-1 >> $src/data-random-$size
		measure_rsync
		line="$line $duration $kiB_sent $kiB_sent_comp"
		# prepend random data block (this can be more efficient)
		cp $pool/data-random-$size $src
		rsync -a $src/ $dst/
		mv $src/data-random-$size $src/data-random-$size.tmp
		cp $pool/data-random-1 $src/data-random-$size
		cat $src/data-random-$size.tmp >> $src/data-random-$size
		rm $src/data-random-$size.tmp
		measure_rsync
		line="$line $duration $kiB_sent $kiB_sent_comp"
		# maybe later:
		# replace data block in the middle
		# shuffle blocks in the file around
		# replace blocks in begin, middle, end
		echo "#size scratch_d scratch_s scratch_sc noop_d noop_s noop_sc append_1_d append_1_s append_1_sc prepend_1_d prepend_1_s prepend_1_sc" >> /tmp/rsyncbench_results_test_random_images.txt
		echo "$line">> /tmp/rsyncbench_results_test_random_images.txt
	done
}