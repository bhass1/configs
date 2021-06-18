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


BINS="7zopen 7zclose hexdiff dosink zap_sdcard"
for bin in $BINS; do
  if ! grep "alias $bin" ~/.bashrc; then
    echo "alias $bin=~/bin/$bin.sh"
    echo "alias $bin=~/bin/$bin.sh" >> ~/.bashrc
  fi
done

#Keys
ALIAS="lspace open login gitgraph"
#Values
ALIAS_lspace='sudo du -h -d 1'
ALIAS_open='xdg-open'
ALIAS_login='eval `ssh-agent` && ssh-add ~/.ssh/id_github'
ALIAS_gitgraph='git log --graph --oneline'

for alias in $ALIAS; do
  ALIAS_var_name=ALIAS_$alias
  if ! grep "alias $alias" ~/.bashrc; then
    echo "alias $alias=$(eval 'echo \$$ALIAS_var_name')"
    echo "alias $alias=$(eval 'echo \$$ALIAS_var_name')" >> ~/.bashrc
  fi
done
