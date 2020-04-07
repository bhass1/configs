#!/bin/bash

BINS="lspace open 7zopen 7zclose hexdiff"

for bin in $BINS; do
  if ! grep "alias $bin" ~/.bashrc; then 
    echo "alias $bin='sudo du -h -d 1'"
    echo "alias $bin='sudo du -h -d 1'" >> ~/.bashrc
  fi
done
