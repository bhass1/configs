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
    echo "$0 ARCHIVE_NAME"
    echo ""
}

if [[ $# != 1 ]]; then
    usage
    exit
fi

7z x $1
