#!/bin/bash
if ! grep "alias lspace" ~/.bashrc; then 
  echo "alias lspace='sudo du -h -d 1'"
  echo "alias lspace='sudo du -h -d 1'" >> ~/.bashrc
fi

if ! grep "alias open" ~/.bashrc; then
  echo "alias open=xdg-open"
  echo "alias open=xdg-open" >> ~/.bashrc
fi
