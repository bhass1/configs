#!/bin/bash
#
#By:Bill Hass
#
# Takes config files from repo and installs them to host

for file in $(ls -A HOME); do
    if [ -f ~/$file ]; then
        if diff ~/$file HOME/$file > /dev/null; then
            echo -e "> ~/$file is already up-to-date\t\t - complete";
        else
            echo "> File Conflict."
            echo "> Diff of ~/$file (<) and ./HOME/$file (>)"
            diff ~/$file HOME/$file
            while true; do
                read -p "    ...         Overwrite?[y/n]" yn
                case $yn in
                    [Yy]* ) cp HOME/$file ~/;echo -e "> ~/$file overwritten\t\t\t - complete"; break;;
                    [Nn]* ) echo -e "> ~/$file not overwritten\t\t\t - skipped"; break;;
                    * ) echo "> You must select y or n!\t\t\t - ERROR!";
                esac
            done
        fi
    else
        cp HOME/$file ~/
        echo -e "> ~/$file newly created\t\t\t - complete";
    fi
done

