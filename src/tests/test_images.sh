#!/bin/sh

function test_run () {
for type in random zeroes
do
	echo "#size scratch_d scratch_s scratch_sc noop_d noop_s noop_sc append_1_d append_1_s append_1_sc prepend_1_d prepend_1_s prepend_1_sc" > /tmp/rsyncbench_results_test_${type}_images.txt
	for size in 1 100 1024
	do
		echo "**** Testing $type image syncing, base size $size MiB"
		echo "** Preparing test.."
		line="$size "
		rm -rf $src/*
		rsync -a --delete $src/ $dst/
		echo "** Testing sync from scratch.."
		cp $pool/data-$type-$size $src
		measure_rsync
		line="$line $duration $kiB_sent $kiB_sent_comp"
		echo "** Testing 'no-op' sync.."
		measure_rsync
		line="$line $duration $kiB_sent $kiB_sent_comp"
		echo "** Testing sync with appended $type data block"
		cat $pool/data-$type-1 >> $src/data-$type-$size
		measure_rsync
		line="$line $duration $kiB_sent $kiB_sent_comp"
		echo "** Testing sync with prepended $type data block" # could be more efficient..
		rsync $pool/data-$type-$size $src/data-$type-$size
		rsync -a $src/ $dst/
		mv $src/data-$type-$size $src/data-$type-$size.tmp
		cp $pool/data-$type-1 $src/data-$type-$size
		cat $src/data-$type-$size.tmp >> $src/data-$type-$size
		rm $src/data-$type-$size.tmp
		measure_rsync
		line="$line $duration $kiB_sent $kiB_sent_comp"
		# maybe later:
		# append/prepend zero blocks
		# replace data block in the middle
		# shuffle blocks in the file around
		# replace blocks in begin, middle, end
		"** Writing results.."
		echo "$line">> /tmp/rsyncbench_results_test_${type}_images.txt
	done
done
}

function test_graph () {
	export TYPE=random TITLE=Random
	type=random
	./test_images_durations.gp > /tmp/rsyncbench_${type}_images_durations.png
	./test_images_sent.gp      > /tmp/rsyncbench_${type}_images_sent.png
	export TYPE=zeroes TITLE=Zeroes
	type=zeroes
	./test_images_durations.gp > /tmp/rsyncbench_${type}_images_durations.png
	./test_images_sent.gp      > /tmp/rsyncbench_${type}_images_sent.png
}
