#!/bin/bash

cd $(dirname $(readlink -f $0)) # jump to the script directory

mkdir -p ~/.config/emacs

ln -s "$(pwd)/mc-lists.el"  ~/.config/emacs/.mc-lists.el
ln -s "$(pwd)/instances/$@" ~/.config/emacs/init.el
