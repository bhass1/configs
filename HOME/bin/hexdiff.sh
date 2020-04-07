#!/bin/bash

function usage {
    echo "> Usage: "
    echo ""
    echo "$0 bin1 bin2"
    echo ""
}

if [[ $# != 2 ]]; then
    usage
    exit
fi

TAG=$(xxd /dev/urandom | head -n 1 | cut -d' ' -f 2)
NAME1=$(basename $1)
NAME2=$(basename $2)

SCRATCH=/tmp/hexdiff/$NAME1-$NAME2-$TAG


mkdir -p $SCRATCH
hexdump -C $1 > $SCRATCH/$NAME1.hex
hexdump -C $2 > $SCRATCH/$NAME2.hex

vimdiff $SCRATCH/$NAME1.hex $SCRATCH/$NAME2.hex
