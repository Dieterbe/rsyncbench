# if you use the vm_images plugin, this script should put your vm images in the pool
# this script gets sourced by the plugin (so we have access to the config)
max_images=10
basename=somefile # if you have somefile.vdi
snapshots_dir=where_your_snapshots_are
subpath=path_inside_snapshots_to_images
if [ $(ls $pool/$basename.vdi* 2>/dev/null | wc -w) -ge $max_images ]
then
	echo "already got enough vm images. returning.."
	return
fi
for file in $snapshots_dir/*/$subpath/$basename.vdi
do
	echo "copying $file, if needed"
	mtime=$(stat -c %Y $file)
	[ -f $pool/$basename.$mtime ] || cp -a $file $pool/$basename.$mtime
done
