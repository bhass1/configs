#!/bin/bash

laptop=bill@192.168.0.111

sync_dst=~/dev1_sync/
sync_src=$laptop:/home/bill/

function usage() {
	echo "Usage: "
	echo "        $0 <push/pull> <dir>"
	echo ""
	echo "Simple wrapper for rsync."
	echo "Will either push from this machine to the remote,"
	echo "or pull from remote to this machine."
	echo ""
	echo "Args:"
	echo "  push/pull : 'push' or 'pull' to choose direction of sync"
	echo "  dir       : path to folder to be syncd relative to /home/bill/"
}

if [ "$#" != "2" ]; then
	usage
	exit 2
fi

sync_path=$2
sync_folder=$(basename $sync_path)
sync_dir=$(dirname $sync_path)

echo "sync_folder: $sync_folder"
echo "sync_path: $sync_path"
if [ "$sync_path" == "$sync_folder" ]; then
	sync_dir=""
fi

if [ "$1" == "push" ]; then
	sync_tmp=$sync_dst
	sync_dst=$sync_src
	sync_src=$sync_tmp

	sync_src=$sync_src$sync_path
	sync_dst=$sync_dst$sync_dir
elif [ "$1" == "pull" ]; then
	sync_src=$sync_src$sync_path
	sync_dst=$sync_dst$sync_dir
else
	usage
	exit 2
fi

echo "About to $1 from $sync_src to $sync_dst"
read -p "Continue [Y/n]?" s
if [ "$s" == "n" ] || [ "$s" == "N" ]; then
	echo "Okay, nevermind..."
	exit 1
fi

rsync -avz --delete --stats --numeric-ids --exclude 'build' -e "ssh -T -l bill -o MACS=umac-64-etm@openssh.com" $sync_src $sync_dst
