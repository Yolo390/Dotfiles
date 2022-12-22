#!/bin/sh

Os=$(uname -s)

if [ ! $Os = 'Linux' ]; then
	echo 'Windows and Mac OS are supported !'
	exit 1
fi

Flo=~/Flo
Apps=~/Flo/Apps
Nvim=~/.config/nvim

# Coucou=~/Coucou
# CoucouApps=~/Coucou/Apps
# CoucouNvim=~/.config/Coucou/nvim

# if [ -d "$Coucou" ] && [ -d "$CoucouApps" ]; then
if [ -d "$Flo" ] && [ -d "$Apps" ]; then
	# echo " ========================================================="
	# echo '   Directories ~/Coucou & ~/Coucou/Apps already exists ! '
	# echo " ========================================================="
	echo "\n"
	echo " ==================================================="
	echo '   Directories ~/Flo & ~/Flo/Apps already exists ! '
	echo " ==================================================="
	exit 1
else
	# mkdir ~/Coucou
	# echo '=== ~/Coucou created ! ==='
	# mkdir ~/Coucou/Apps
	# echo '=== ~/Coucou/Apps created ! ==='
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
	# Neovim
	echo "\n"
	echo "========================="
	echo "    INSTALLING NEOVIM    "
	echo "========================="
	echo "\n"
	echo '=== dependencies ==='
	echo "\n"
	sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake \
	cmake g++ pkg-config doxygen
	echo '=== remove existing vim ==='
	echo "\n"
	sudo apt remove -y vim
	echo '=== git clone ==='
	echo "\n"
	# git clone -b release-0.8 https://github.com/neovim/neovim ~/Coucou/Apps/Neovim
	git clone -b release-0.8 https://github.com/neovim/neovim ~/Flo/Apps/Neovim
	# cd ~/Coucou/Apps/Neovim
	cd ~/Flo/Apps/Neovim
	echo '=== make ==='
	echo "\n"
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	echo '=== make install ==='
	echo "\n"
	sudo make install
	cd ~
	echo "\n"
	echo "=========================="
	echo "    NEOVIM INSTALLED !    "
	echo "=========================="
	echo "\n"
	# Pynvim
	echo "\n"
	echo "========================="
	echo "    INSTALLING PYNVIM    "
	echo "========================="
	echo "\n"
	pip3 install pynvim
	echo "\n"
	echo "=========================="
	echo "    PYNVIM INSTALLED !    "
	echo "=========================="
	echo "\n"
	# Packer
	echo "\n"
	echo "========================="
	echo "    INSTALLING PACKER    "
	echo "========================="
	echo "\n"
	git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
	echo "\n"
	echo "=========================="
	echo "    PACKER INSTALLED !    "
	echo "=========================="
	echo "\n"
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
fi
