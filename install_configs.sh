#!/bin/bash
#
#By:Bill Hass
#
# Takes config files from repo and installs them to host

function do_replace {
    local SRC=$1
    local DEST=$2
    local FILE=$3
    cp $SRC/$FILE $DEST/$FILE
    echo -e "> $DEST/$FILE overwritten\t\t\t - complete"
}

function no_replace {
    local SRC=$1
    local DEST=$2
    local FILE=$3
    echo -e "> $DEST/$FILE not overwritten\t\t\t - skipped"
}

function install_file {
    local SRC=$1
    local DEST=$2
    local FILE=$3
    if [ -f $DEST/$FILE ]; then
        if diff $DEST/$FILE $SRC/$FILE > /dev/null; then
            echo -e "> $DEST/$FILE is already up-to-date\t\t - complete";
        else
            echo "> File Conflict."
            echo "> Diff of $DEST/$FILE (<) and $SRC/$FILE (>)"
            diff $DEST/$FILE $SRC/$FILE
            while true; do
                read -p "    ...         Overwrite?[y/n]" yn
                case $yn in
                    [Yy]* ) do_replace "$SRC" "$DEST" "$FILE"; break;;
                    [Nn]* ) no_replace "$SRC" "$DEST" "$FILE"; break;;
                    * ) echo -e "> You must select y or n!\t\t\t - ERROR!";
                esac
            done
        fi
    else
        mkdir -p $DEST
        cp $SRC/$FILE $DEST/$FILE
        echo -e "> $DEST/$FILE newly created\t\t\t - complete";
    fi
}

function install_dir {
    local SRC=$1
    local DEST=$2

    for file in $(ls -A $SRC); do
        if [ -f $SRC/$file ]; then
            install_file "$SRC" "$DEST" "$file"
        elif [ -d $SRC/$file ]; then
            install_dir $SRC/$file $DEST/$file
        fi
    done
}

install_dir "HOME" ~

./append_bashrc.sh
source ./.bashrc
