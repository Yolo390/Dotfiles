#!/bin/sh

Flo=~/Flo
Apps=~/Flo/Apps

# Coucou=~/Coucou
# CoucouApps=~/Coucou/Apps

# if [ -d "$Coucou" ] && [ -d "$CoucouApps" ]
if [ -d "$Flo" ] && [ -d "$Apps" ]
then
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
	sudo apt update
	sudo apt upgrade -y
	# Globals dependencies
	sudo apt install -y ripgrep fd-find silversearcher-ag bat \
	mlocate zoxide python3-pip libsqlite3-dev libssl-dev
	# Neovim
	echo "\n"
	echo "========================="
	echo "    INSTALLING NEOVIM    "
	echo "========================="
	echo "\n"
	sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake \
	cmake g++ pkg-config doxygen
	sudo apt remove -y vim
	# git clone -b release-0.8 https://github.com/neovim/neovim ~/Coucou/Apps/Neovim
	git clone -b release-0.8 https://github.com/neovim/neovim ~/Flo/Apps/Neovim
	# cd ~/Coucou/Apps/Neovim
	cd ~/Flo/Apps/Neovim
	make CMAKE_BUILD_TYPE=RelWithDebInfo
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
	sudo apt install -y libevent-dev ncurses-dev build-essential bison
	sudo apt remove -y tmux
	sudo apt autoremove -y
	rm -rf .tmux
	echo "\n"
	echo "========================"
	echo "    TMUX INSTALLED !    "
	echo "========================"
	echo "\n"
fi
