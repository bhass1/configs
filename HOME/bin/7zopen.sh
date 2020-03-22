#!/bin/bash

function usage {
    echo "> Usage: "
    echo ""
    echo "$0 ARCHIVE_NAME"
    echo ""
}

if [[ $# != 1 ]]; then
    usage
    exit
fi

7z x $1
