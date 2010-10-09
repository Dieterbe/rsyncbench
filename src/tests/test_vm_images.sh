#!/bin/sh
# this plugin shows you the cost of rsyncing virtual machine images (or whichever files you want, really)
# the idea being that a virtual disk image is a good real life example for a big file with various random changes
set -e

function test_init () {
	source $test_vm_images_fetch
}
function test_run () {
	rm -rf $src/*
}
