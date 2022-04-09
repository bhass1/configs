#!/bin/bash
#
# Copyright 2020 Bill Hass
# 
# Small script to flash a binary image to an SD-Card or other block device.
#

set -e

DEV_NODE=/dev/mmcblk0
IMAGE=tmp/deploy/images/nitrogen8mm/boundary-image-multimedia-full-nitrogen8mm.wic

function usage() {
  echo "$(basename $0), a small script to flash a binary image to an SD-Card or other block device"
  echo ""
  echo "Usage: $(basename $0) <IMAGE> [<DEV_NODE>]"
  echo ""
  echo "IMAGE    - path to binary image to write from (default: $IMAGE)"
  echo "DEV_NODE - path to device node to write to (default: $DEV_NODE)"
}

function check_dev_node() {
  dev_node=$1
  warn=0
  lsblk -o HOTPLUG,NAME,SIZE,MOUNTPOINT $dev_node
  for output in $(lsblk -no HOTPLUG,NAME,SIZE,MOUNTPOINT $dev_node | tr -s [:space:] | cut -f 2 -d' '); do
    if [ ! "$output" == "1" ]; then
      warn=1
    fi
  done
  if [ "$warn" == "1" ]; then
    echo "> WARNING! Device isn't hotpluggable, ensure $DEV_NODE is correct!"
  fi
}

if [ ! -z "$1" ]; then
  if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    usage
    exit 1
  fi
  >&2 echo "> Overriding default $IMAGE"
  >&2 echo "    With supplied    $1"
  IMAGE="$1"
fi

if [ ! -z "$2" ]; then
  >&2 echo "> Overriding default $DEV_NODE"
  >&2 echo "    With supplied    $2"
  DEV_NODE=$2
fi

>&2 echo "> Using IMAGE = $IMAGE"
>&2 echo "> Using DEV_NODE = $DEV_NODE"
check_dev_node $DEV_NODE

# Unmount DEV_NODE
for line in $(mount | grep $DEV_NODE | cut -f 1 -d' '); do
  >&2 echo "> Unmounting $line"
  sudo umount $line
done

count=100
echo "> Zeroing first ${count}MB..."
sudo dd if=/dev/zero of=$DEV_NODE bs=1M count=$count conv=fsync oflag=direct status=progress

echo "> Flashing image..."
sudo dd if=$IMAGE of=$DEV_NODE bs=1M conv=fsync status=progress oflag=direct

>&2 echo "> Syncing..."
sync
sync

>&2 echo "> Done!"
