#!/bin/bash

addpkg() {
	if ! [ -x "$(command -v $1)" ]; then
		echo "[applyconfig] installing $1"
		apt-get install $1 -y
	fi
}

# install stuff if needed
echo "[applyconfig] updating..."
if ! apt-get update 1> /dev/null ; then
	echo "failed to apt-get update, are you root?"
	exit 1
fi
echo "[applyconfig] installing..."
addpkg emacs-nox
if ! [ -e "/proc/sys/fs/binfmt_misc/WSLInterop" ]; then
	#only add firefox if not in wsl
	addpkg firefox-esr
fi
curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf -
bash ble-nightly/ble.sh --install ~/.local/share

echo "[applyconfig] configuring..."

# Setup dotfiles from config dir
if ! cp -r config/ -t ~/ ; then exit 1; fi
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

echo "[applyconfig] success!"
echo "[applyconfig] would you like to delete this repository from this device?"
while true; do
	read -p "[y/n]: " yn
	case $yn in
		[Yy]*) rm -rf . ; exit 0 ;;
		[Nn]*) echo "[applyconfig] ok!" ; exit 0 ;;
	esac
done
