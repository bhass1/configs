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



#
# Tries to politely install config files from HOME to host
#

function do_replace {
    local from_dir=$1
    local to_dir=$2
    local file=$3
    cp $from_dir/$file $to_dir/$file
    echo -e "> $to_dir/$file overwritten\t\t\t - complete"
}

function no_replace {
    local from_dir=$1
    local to_dir=$2
    local file=$3
    echo -e "> $to_dir/$file not overwritten\t\t\t - skipped"
}

function defer_user {

function install_file {
# Compares with existing file in to_dir, if different, use stdin to
# determine for overwrite
    local from_dir=$1
    local to_dir=$2
    local file=$3
    if [ -f $to_dir/$file ]; then
        if diff $to_dir/$file $from_dir/$file > /dev/null; then
            echo -e "> $to_dir/$file is already up-to-date\t\t - complete";
        else
            echo "> File Conflict."
            echo "> Diff of $to_dir/$file (<) and $from_dir/$file (>)"
            diff $to_dir/$file $from_dir/$file
            while true; do
                read -p "    ...         Overwrite?[y/n]" yn
                case $yn in
                    [Yy]* ) do_replace "$from_dir" "$to_dir" "$file"; break;;
                    [Nn]* ) no_replace "$from_dir" "$to_dir" "$file"; break;;
                    * ) echo -e "> You must select y or n!\t\t\t - ERROR!";
                esac
            done
        fi
    else
        mkdir -p $to_dir
        cp $from_dir/$file $to_dir/$file
        echo -e "> $to_dir/$file newly created\t\t\t - complete";
    fi
}

function install_dir {
    local from_dir=$1
    local to_dir=$2

    for file in $(ls -A $from_dir); do
        if [ -f $from_dir/$file ]; then
            install_file "$from_dir" "$to_dir" "$file"
        elif [ -d $from_dir/$file ]; then
            install_dir $from_dir/$file $to_dir/$file
        fi
    done
}

install_dir "./data/HOME" ~

./util/append_bashrc.sh
source ~/.bashrc
