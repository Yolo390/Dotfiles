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
printf "\n"

printf "  Please set your folder name: "
read folderName

printf "\n"
printf "  It will create two folder: ~/%s and ~/%s/Apps/Neovim\n" "$folderName" "$folderName"
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
printf "  Are you sure to want to set '%s' as folder name ? (y/n): " "$folderName"
read choice
printf "\n"

case "$choice" in
	"y"|"yes"|"Y"|"YES")
		break
		;;
	*)
		printf "  Nothing has been created and installed !\n"
		printf "  See you soon ! :)\n"
		exit 1
		;;
esac

printf "  Please set your neovim username: "
read neovimUsername
echo "\n"

Flo="$HOME/$username"
Apps="$HOME/$username/Apps"
Neovim="$HOME/$username/Apps/Neovim"
Nvim="$HOME/.config/nvim"

# Coucou="$HOME/Coucou"
# CoucouApps="$HOME/Coucou/Apps"
# CoucouNvim="$HOME/.config/Coucou/nvim"

# if [ -d "$Coucou" ] && [ -d "$CoucouApps" ]; then
if [ -d "$Flo" ] && [ -d "$Apps" ]; then
	# printf " ========================================================="
	# printf '   Directories ~/Coucou & ~/Coucou/Apps already exists ! '
	# printf " ========================================================="
	printf "\n"
	printf "  === Directories ~/Flo & ~/Flo/Apps already exists ! ===\n"
	printf "\n"
	exit 1
else
	# mkdir ~/Coucou
	# printf "=== ~/Coucou created ! ==="
	# mkdir ~/Coucou/Apps
	# printf "=== ~/Coucou/Apps created ! ==="
	mkdir ~/Flo
	printf "=== ~/Flo created ! ===\n"
	printf "\n"
	mkdir ~/Flo/Apps
	printf '=== ~/Flo/Apps created ! ==='
	printf "\n"
	printf '=== apt update ==='
	printf "\n"
	sudo apt update
	printf '=== apt upgrade ==='
	printf "\n"
	sudo apt upgrade -y
	# Global dependencies
	printf '=== install global dependencies ==='
	printf "\n"
	sudo apt install -y ripgrep fd-find silversearcher-ag bat \
	mlocate zoxide python3-pip libsqlite3-dev libssl-dev
	# Neovim
	printf "\n"
	printf "========================="
	printf "    INSTALLING NEOVIM    "
	printf "========================="
	printf "\n"
	printf '=== dependencies ==='
	printf "\n"
	sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake \
	cmake g++ pkg-config doxygen
	printf '=== remove existing vim ==='
	printf "\n"
	sudo apt remove -y vim
	printf '=== git clone release-0.8 ==='
	printf "\n"
	# git clone -b release-0.8 https://github.com/neovim/neovim ~/Coucou/Apps/Neovim
	git clone -b release-0.8 https://github.com/neovim/neovim ~/Flo/Apps/Neovim
	# cd ~/Coucou/Apps/Neovim
	cd ~/Flo/Apps/Neovim
	printf '=== make ==='
	printf "\n"
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	printf '=== make install ==='
	printf "\n"
	sudo make install
	cd ~
	printf "\n"
	printf "=========================="
	printf "    NEOVIM INSTALLED !    "
	printf "=========================="
	printf "\n"
	# Pynvim
	printf "\n"
	printf "========================="
	printf "    INSTALLING PYNVIM    "
	printf "========================="
	printf "\n"
	pip3 install pynvim
	printf "\n"
	printf "=========================="
	printf "    PYNVIM INSTALLED !    "
	printf "=========================="
	printf "\n"
	# Packer
	printf "\n"
	printf "========================="
	printf "    INSTALLING PACKER    "
	printf "========================="
	printf "\n"
	git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
	printf "\n"
	printf "=========================="
	printf "    PACKER INSTALLED !    "
	printf "=========================="
	printf "\n"
	# Neovim config
	printf "\n"
	printf "==================="
	printf "   NEOVIM CONFIG   "
	printf "==================="
	printf "\n"
	printf '=== create folder structure ==='
	printf "\n"
	cd ~/.config
	mkdir -p nvim/lua nvim/after/plugin nvim/after/ftplugin nvim/lua/FloSlv/undodir
	printf '=== install config files ==='
	printf "\n"
	wget -P ~/.config/nvim/lua/FloSlv -O options.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/options.lua
	wget -P ~/.config/nvim/lua/FloSlv -O keymaps.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/keymaps.lua
	wget -P ~/.config/nvim/lua/FloSlv -O utils.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/utils.lua
	wget -P ~/.config/nvim/lua/FloSlv  -O packer.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/packer.lua
	wget -P ~/.config/nvim -O init.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/init.lua
	printf "\n"
	printf "============================="
	printf "   NEOVIM CONFIG INSTALLED   "
	printf "============================="
	printf "\n"
	printf '=== neovim version ==='
	printf "\n"
	nvim --version
fi
