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


BINS="7zopen 7zclose hexdiff"
for bin in $BINS; do
  if ! grep "alias $bin" ~/.bashrc; then 
    echo "alias $bin=~/bin/$bin.sh"
    echo "alias $bin=~/bin/$bin.sh" >> ~/.bashrc
  fi
done

if ! grep "alias lspace" ~/.bashrc; then 
  echo "alias lspace='sudo du -h -d 1'"
  echo "alias lspace='sudo du -h -d 1'" >> ~/.bashrc
fi
if ! grep "alias open" ~/.bashrc; then 
  echo "alias open='xdg-open'"
  echo "alias lspace='xdg-open'" >> ~/.bashrc
fi


