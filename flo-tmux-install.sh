#!/bin/sh

set -e pipefail

Os="$(uname -s)"

if [ ! "$Os" = 'Linux' ]; then
	echo 'Windows and Mac OS are not supported !'
	exit 1
fi

echo "========================================="
echo "=== Welcome to Flo-tmux installer ! ==="
echo "========================================="
echo "\n"

read -p 'Please set your username: ' username

echo "\n"
echo "It will create two folders: $HOME/$username and $HOME/$username/Apps/Tmux"
echo "\n"
echo "Are you sure to want to set '$username' as folder name ?"


Flo="$HOME/$username"
Apps="$HOME/$username/Apps"
Tmux="$HOME/$username/Apps/Tmux"

if [ -d "$Flo" ] && [ -d "$Apps" ]; then
	echo "\n"
	echo " ==================================================="
	echo '   Directories ~/Flo & ~/Flo/Apps already exists ! '
	echo " ==================================================="
	exit 1
else
	mkdir ~/Flo
	echo '=== ~/Flo created ! ==='
	echo "\n"
	mkdir ~/Flo/Apps
	echo '=== ~/Flo/Apps created ! ==='
	echo "\n"
	echo '=== apt update ==='
	echo "\n"
	sudo apt update
	echo '=== apt upgrade ==='
	echo "\n"
	sudo apt upgrade -y
	# Global dependencies
	echo '=== install global dependencies ==='
	echo "\n"
	sudo apt install -y ripgrep fd-find silversearcher-ag bat \
	mlocate zoxide python3-pip libsqlite3-dev libssl-dev
	# Tmux
	echo "\n"
	echo "======================="
	echo "    INSTALLING TMUX    "
	echo "======================="
	echo "\n"
	echo '=== dependencies ==='
	echo "\n"
	sudo apt install -y libevent-dev ncurses-dev build-essential bison
	echo '=== remove existing tmux ==='
	echo "\n"
	sudo apt remove -y tmux
	echo '=== autoremove ==='
	echo "\n"
	sudo apt autoremove -y
	echo '=== remove existing .tmux ==='
	echo "\n"
	rm -rf .tmux
	echo '=== git clone ==='
	echo "\n"
	git clone https://github.com/tmux/tmux.git ~/Flo/Apps/Tmux
	cd ~/Flo/Apps/Tmux
	echo '=== autogen ==='
	echo "\n"
	sh autogen.sh
	echo '=== configure ==='
	echo "\n"
	./configure
	echo '=== make ==='
	echo "\n"
	make
	echo '=== make install ==='
	echo "\n"
	sudo make install
	echo "\n"
	echo "========================"
	echo "    TMUX INSTALLED !    "
	echo "========================"
	echo "\n"
	echo '=== tmux version ==='
	echo "\n"
	tmux -V
fi
