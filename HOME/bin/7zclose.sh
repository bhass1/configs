#!/bin/bash

function usage {
    echo "> Usage: "
    echo ""
    echo "$0 ARCHIVE_NAME TARGET_DIR"
    echo ""
}

if [[ $# != 2 ]]; then
    usage
    exit
fi

7z a \
  -t7z -m0=lzma2 -mfb=64 \
  -md=32m -ms=on -mhe=on -p \
   "$1".7z $2
