#!/bin/bash
if ! grep "alias lspace" ~/.bashrc; then 
  echo "alias lspace='sudo du -h -d 1'"
  echo "alias lspace='sudo du -h -d 1'" >> ~/.bashrc
fi

if ! grep "alias open" ~/.bashrc; then
  echo "alias open=xdg-open"
  echo "alias open=xdg-open" >> ~/.bashrc
fi

if ! grep "alias 7zopen" ~/.bashrc; then
  echo "alias 7zopen=~/bin/7zopen.sh"
  echo "alias 7zopen=~/bin/7zopen.sh" >> ~/.bashrc
fi

if ! grep "alias 7zclose" ~/.bashrc; then
  echo "alias 7zclose=~/bin/7zclose.sh"
  echo "alias 7zclose=~/bin/7zclose.sh" >> ~/.bashrc
fi
