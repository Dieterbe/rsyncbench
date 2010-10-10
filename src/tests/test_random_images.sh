#!/bin/sh

function test_run () {
	echo "#size scratch_d scratch_s scratch_sc noop_d noop_s noop_sc append_1_d append_1_s append_1_sc prepend_1_d prepend_1_s prepend_1_sc" > /tmp/rsyncbench_results_test_random_images.txt
	for size in 1 100 1024
	do
		echo "Preparing test.."
		line="$size "
		rm -rf $src/*
		rsync -a --delete $src/ $dst/
		echo "Testing sync from scratch.."
		cp $pool/data-random-$size $src
		measure_rsync
		line="$line $duration $kiB_sent $kiB_sent_comp"
		echo "Testing 'no-op' sync.."
		measure_rsync
		line="$line $duration $kiB_sent $kiB_sent_comp"
		echo "Testing sync with appended random data block"
		cat $pool/data-random-1 >> $src/data-random-$size
		measure_rsync
		line="$line $duration $kiB_sent $kiB_sent_comp"
		echo "Testing sync with prepended random data block" # could be more efficient..
		rsync $pool/data-random-$size $src/data-random-$size
		rsync -a $src/ $dst/
		mv $src/data-random-$size $src/data-random-$size.tmp
		cp $pool/data-random-1 $src/data-random-$size
		cat $src/data-random-$size.tmp >> $src/data-random-$size
		rm $src/data-random-$size.tmp
		measure_rsync
		line="$line $duration $kiB_sent $kiB_sent_comp"
		# maybe later:
		# append/prepend zero blocks
		# replace data block in the middle
		# shuffle blocks in the file around
		# replace blocks in begin, middle, end
		echo "$line">> /tmp/rsyncbench_results_test_random_images.txt
	done
}

function test_graph () {
	 ./test_random_images_durations.gp > /tmp/random_images_durations.png
	 ./test_random_images_sent.gp      > /tmp/random_images_sent.png
}
