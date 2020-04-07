#!/bin/bash

## SPDX-License-Identifier: GPL-3.0-or-later 
## Copyright 2020 Bill Hass
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

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
