#!/bin/sh

Os=$(uname -s)

if [ ! $Os = 'Linux' ]; then
	echo 'Windows and Mac OS are not supported !'
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
	echo '=== git clone release-0.8 ==='
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
	# Neovim config
	echo "\n"
	echo "==================="
	echo "   NEOVIM CONFIG   "
	echo "==================="
	echo "\n"
	echo '=== create folder structure ==='
	echo "\n"
	cd ~/.config
	mkdir -p nvim/lua nvim/after/plugin nvim/after/ftplugin nvim/lua/FloSlv/undodir
	echo '=== install config files ==='
	echo "\n"
	wget -P ~/.config/nvim/lua/FloSlv -O options.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/options.lua
	wget -P ~/.config/nvim/lua/FloSlv -O keymaps.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/keymaps.lua
	wget -P ~/.config/nvim/lua/FloSlv -O utils.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/utils.lua
	wget -P ~/.config/nvim/lua/FloSlv  -O packer.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/packer.lua
	wget -P ~/.config/nvim -O init.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/init.lua
	echo "\n"
	echo "============================="
	echo "   NEOVIM CONFIG INSTALLED   "
	echo "============================="
	echo "\n"
	echo '=== neovim version ==='
	echo "\n"
	nvim --version
fi
