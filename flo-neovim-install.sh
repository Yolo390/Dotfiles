#!/bin/sh

# In this script, I use `printf` instead of `echo` to have a better compatibility w/ all shell.

set -e pipefail

Os="$(uname -s)"

if [ ! "$Os" = "Linux" ]; then
		printf "\n"
		printf "  ================================================\n"
		printf "                  I am sorry ...                  \n"
		printf "                                                  \n"
		printf "  Windows and Mac OS are currently not supported !\n"
		printf "                                                  \n"
		printf "  ================================================\n"
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

	if [ "$folderName" = "" ]; then
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
			printf "  ================================================\n"
			printf "      Nothing has been created and installed.     \n"
			printf "                                                  \n"
			printf "                  See you soon :)                 \n"
			printf "  ================================================\n"
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

BaseDirectory="$HOME/$folderName"
Apps="$HOME/$folderName/Apps"
Neovim="$HOME/$folderName/Apps/Neovim"
Nvim="$HOME/.config/nvim"

# Coucou\n"$HOME/Coucou"
# CoucouApps\n"$HOME/Coucou/Apps"
# CoucouNvim\n"$HOME/.config/Coucou/nvim"

# if [ -d "$Coucou" ] && [ -d "$CoucouApps" ]; then
if [ -d "$Neovim" ]; then
	# printf " ========================================================\n"
	# printf '   Directories ~/Coucou & ~/Coucou/Apps already exists ! '
	# printf " ========================================================\n"
	printf "\n"
	printf "  ================================================\n"
	printf "   Directory ~/%s/Apps/Neovim already exists !    \n" "$folderName"
	printf "                                                  \n"
	printf "     Please delete it then re run this script.    \n"
	printf "                                                  \n"
	printf "      Nothing has been created and installed.     \n"
	printf "                                                  \n"
	printf "                  See you soon :)                 \n"
	printf "  ================================================\n"
	printf "\n"
	exit 1
elif [ -d "$Apps" ]; then
	continue
elif [ -d "$BaseDirectory" ]; then
	mkdir $Apps
	printf "=== ~/%s/Apps created ! ===\n" "$BaseDirectory"
	printf "\n"
else
	# mkdir ~/Coucou
	# printf "=== ~/Coucou created ! ==\n"
	# mkdir ~/Coucou/Apps
	# printf "=== ~/Coucou/Apps created ! ==\n"
	mkdir $BaseDirectory
	printf "=== ~/%s created ! ===\n" "$BaseDirectory"
	printf "\n"
	mkdir $Apps
	printf "=== ~/%s/Apps created ! ===\n" "$BaseDirectory"
	printf "\n"
fi

printf "=== apt update ===\n"
printf "\n"
sudo apt update
printf "=== apt upgrade ===\n"
printf "\n"
sudo apt upgrade -y

# Neovim install
printf "\n"
printf "=========================\n"
printf "    INSTALLING NEOVIM    \n"
printf "=========================\n"
printf "\n"
printf "=== dependencies ===\n"
printf "\n"
sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake \
cmake g++ pkg-config doxygen zoxide python3-pip \
mlocate  libsqlite3-dev libssl-dev ripgrep fd-find silversearcher-ag bat \
libicu-dev libboost-all-dev
printf "=== git clone release-0.8 ===\n"
printf "\n"
# git clone -b release-0.8 https://github.com/neovim/neovim ~/Coucou/Apps/Neovim
git clone -b release-0.8 https://github.com/neovim/neovim ~/Flo/Apps/Neovim
# cd ~/Coucou/Apps/Neovim
cd ~/Flo/Apps/Neovim
printf "=== make ===\n"
printf "\n"
make CMAKE_BUILD_TYPE=RelWithDebInfo
printf "=== make install ===\n"
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
printf "=== create folder structure ===\n"
printf "\n"
cd ~/.config
mkdir -p nvim/lua nvim/after/plugin nvim/after/ftplugin nvim/lua/FloSlv/undodir
printf "=== install config files ===\n"
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

# Neovim version
printf "\n"
printf "=== neovim version ===\n"
printf "\n"
nvim --version
