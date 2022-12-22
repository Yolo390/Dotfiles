#!/bin/sh

# In this script, I use `printf` instead of `echo` to have a better compatibility w/ all shell.

set -e pipefail

Os="$(uname -s)"

if [ ! "$Os" == "Linux" ]; then
	printf "=== Windows and Mac OS are not supported ! ===\n"
	printf "\n"
	exit 1
fi

printf "\n"
printf "  =========================================\n"
printf "  === Welcome to Flo-neovim installer ! ===\n"
printf "  =========================================\n"

while true; do
	printf "\n"
	printf "  Please set your folder name: "
	read folderName

	if [ $folderName == ""]; then
		printf "\n"
		printf "  You need to enter a folder name !\n"
		continue
	fi

	printf "\n"
	printf "  It will create two folders: ~/%s and ~/%s/Apps/Neovim\n" "$folderName" "$folderName"
	printf "  to get the following folder tree\n\n"
	printf "  /home\n"
	printf "     │\n"
	printf "     └─ %s\n" "$USER"
	printf "          │\n"
	printf "          └─ %s\n" "$folderName"
	printf "              │\n"
	printf "              └─ Apps\n"
	printf "                  │\n"
	printf "                  └─ Neovim\n"
	printf "\n"
	printf "  If ~/%s/Apps/Neovim already exist, it will delete it !\n" "$folderName"
	printf "\n"
	printf "  Continue with '%s' as folder name ? [y]es, [n]o or [q]uit): " "$folderName"
	read choice

	case "$choice" in
		y|yes|Y|YES|YEs|YeS|yeS|yES)
			break
			;;
		n|N|no|NO|No|nO)
			continue
			;;
		*)
			printf "\n"
			printf "  Nothing has been created and installed !\n"
			printf "  See you soon ! :)\n"
			exit 1
			;;
	esac
done

while true; do
	printf "\n"
	printf "  Please set your neovim username: "
	read neovimUsername

	case $neovimUsername in
		"")
			printf "\n"
			printf "  You need to enter an username to set the neovim config !\n"
			continue
			;;
		*)
			break
			;;
	esac
done

echo "\n"

Flo="$HOME/$username"
Apps="$HOME/$username/Apps"
Neovim="$HOME/$username/Apps/Neovim"
Nvim="$HOME/.config/nvim"

# Coucou\n"$HOME/Coucou"
# CoucouApps\n"$HOME/Coucou/Apps"
# CoucouNvim\n"$HOME/.config/Coucou/nvim"

# if [ -d "$Coucou" ] && [ -d "$CoucouApps" ]; then
if [ -d "$Flo" ] && [ -d "$Apps" ]; then
	# printf " ========================================================\n"
	# printf '   Directories ~/Coucou & ~/Coucou/Apps already exists ! '
	# printf " ========================================================\n"
	printf "\n"
	printf "  === Directories ~/Flo & ~/Flo/Apps already exists ! ===\n"
	printf "\n"
	exit 1
else
	# mkdir ~/Coucou
	# printf "=== ~/Coucou created ! ==\n"
	# mkdir ~/Coucou/Apps
	# printf "=== ~/Coucou/Apps created ! ==\n"
	mkdir ~/Flo
	printf "=== ~/Flo created ! ===\n"
	printf "\n"
	mkdir ~/Flo/Apps
	printf "=== ~/Flo/Apps created ! ===\n"
	printf "\n"
	printf "=== apt update ===\n"
	printf "\n"
	sudo apt update
	printf "=== apt upgrade ===\n"
	printf "\n"
	sudo apt upgrade -y
	# Global dependencies
	printf "=== install global dependencies ==="
	printf "\n"
	sudo apt install -y ripgrep fd-find silversearcher-ag bat \
	mlocate zoxide python3-pip libsqlite3-dev libssl-dev
	# Neovim
	printf "\n"
	printf "=========================\n"
	printf "    INSTALLING NEOVIM    \n"
	printf "=========================\n"
	printf "\n"
	printf "=== dependencies ===\n"
	printf "\n"
	sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake \
	cmake g++ pkg-config doxygen
	printf "=== remove existing vim ===\n"
	printf "\n"
	sudo apt remove -y vim
	printf "=== git clone release-0.8 ===\n"
	printf "\n"
	# git clone -b release-0.8 https://github.com/neovim/neovim ~/Coucou/Apps/Neovim
	git clone -b release-0.8 https://github.com/neovim/neovim ~/Flo/Apps/Neovim
	# cd ~/Coucou/Apps/Neovim
	cd ~/Flo/Apps/Neovim
	printf "=== make ===\n"
	printf "\n"
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	printf "=== make install ==="
	printf "\n"
	sudo make install
	cd ~
	printf "\n"
	printf "==========================\n"
	printf "    NEOVIM INSTALLED !    \n"
	printf "==========================\n"
	printf "\n"
	# Pynvim
	printf "\n"
	printf "=========================\n"
	printf "    INSTALLING PYNVIM    \n"
	printf "=========================\n"
	printf "\n"
	pip3 install pynvim
	printf "\n"
	printf "==========================\n"
	printf "    PYNVIM INSTALLED !    \n"
	printf "==========================\n"
	printf "\n"
	# Packer
	printf "\n"
	printf "=========================\n"
	printf "    INSTALLING PACKER    \n"
	printf "=========================\n"
	printf "\n"
	git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
	printf "\n"
	printf "==========================\n"
	printf "    PACKER INSTALLED !    \n"
	printf "==========================\n"
	printf "\n"
	# Neovim config
	printf "\n"
	printf "=====================\n"
	printf "    NEOVIM CONFIG    \n"
	printf "=====================\n"
	printf "\n"
	printf "=== create folder structure ==="
	printf "\n"
	cd ~/.config
	mkdir -p nvim/lua nvim/after/plugin nvim/after/ftplugin nvim/lua/FloSlv/undodir
	printf "=== install config files ==="
	printf "\n"
	wget -P ~/.config/nvim/lua/FloSlv -O options.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/options.lua
	wget -P ~/.config/nvim/lua/FloSlv -O keymaps.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/keymaps.lua
	wget -P ~/.config/nvim/lua/FloSlv -O utils.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/utils.lua
	wget -P ~/.config/nvim/lua/FloSlv  -O packer.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/packer.lua
	wget -P ~/.config/nvim -O init.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/init.lua
	printf "\n"
	printf "===============================\n"
	printf "    NEOVIM CONFIG INSTALLED    \n"
	printf "===============================\n"
	printf "\n"
	printf "=== neovim version ==="
	printf "\n"
	nvim --version
fi
