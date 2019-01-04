#!/bin/bash

cd $(dirname $(readlink -f $0)) # jump to the script directory

ln -s "$(pwd)/mc-lists.el"  ~/.emacs.d/.mc-lists.el
ln -s "$(pwd)/instances/$@" ~/.emacs.d/init.el
