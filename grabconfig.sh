#!/bin/bash
grab() {
	if [ $# == 1 ]; then
		echo "grabbing ~/$1"
		cp ~/$1 .
	else
		echo "grabbing ~/$1/$2"
		mkdir -p $1
		cp -r ~/$1/$2 -t $1
	fi
}
if [ ! -d config ]; then
	mkdir config
fi
cd config
grab .config/emacs init.el
grab .config/emacs extensions
grab .config/i3    config
grab .config/X11   xmodmap
grab .bashrc
