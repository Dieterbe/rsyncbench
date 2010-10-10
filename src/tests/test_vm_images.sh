#!/bin/sh
# this plugin shows you the cost of rsyncing virtual machine images (or whichever files you want, really)
# the idea being that a virtual disk image is a good real life example for a big file with various random changes
set -e

function test_init () {
	source $test_vm_images_fetch
}
function test_run () {
	# maybe a separate graph with filesizes
	echo "#date time d s sc" > /tmp/rsyncbench_results_test_vm_images.txt
	echo "**** Testing VM image syncing, using the following images:"
	ls -lh $pool/*vdi*
	echo "** Preparing test.."
	# make $dst empty, make $src empty except for maybe an older vm_image we could reuse
	empty_src=$(mktemp -d)
	rsync -a --delete $empty_src/ $dst/
	rmdir $empty_src
	find $src -mindepth 1 ! -name vm_image -delete
	[ -f $src/vm_image ] || touch $src/vm_image
	for i in $(ls -rt $pool/*vdi*)
	do
		echo "** Putting $i in place"
		rsync -a $i $src/vm_image
		echo "** Syncing $i to dst"
		measure_rsync
		mtime=$(stat -c %Y $i)
		datetime=$(date +'%F %T' -d @$mtime)
		echo "** Writing results.."
		line="$datetime $duration $sent $sent_comp"
		echo "$line">> /tmp/rsyncbench_results_test_vm_images.txt
	done
}
function test_graph () {
	./test_vm_images_durations.gp > rsyncbench_vm_images_durations.png
	./test_vm_images_sent.gp      > rsyncbench_vm_images_sent.png
}
