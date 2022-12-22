#!/bin/sh

# In this script, I use `printf` instead of `echo` to have a better compatibility w/ all shell.

set -e pipefail

Os="$(uname -s)"

if [ ! "$Os" = "Linux" ]; then
		printf "\n"
		printf "  ================================================\n"
		printf "                                                  \n"
		printf "                  I am sorry ...                  \n"
		printf "                                                  \n"
		printf "  Windows and Mac OS are currently not supported !\n"
		printf "                                                  \n"
		printf "  ================================================\n"
		exit 1
fi

if ! which node > /dev/null; then
		printf "\n"
		printf "  ================================================\n"
		printf "                                                  \n"
		printf "                  I am sorry ...                  \n"
		printf "                                                  \n"
		printf "        You need to install node.js first !       \n"
		printf "                                                  \n"
		printf "  ================================================\n"
		exit 1
fi

printf "\n"
printf "  =========================================\n"
printf "                                           \n"
printf "      Welcome to Flo-neovim installer !    \n"
printf "                                           \n"
printf "  =========================================\n"

while true; do
	printf "\n"
	printf "  Please set your folder name.\n"
	printf "  e.g.: 'Flo' will create ~/Flo\n"
	printf "\n"
	printf "  Folder name: "
	read FolderName

	if [ "$FolderName" = "" ]; then
		printf "\n"
		printf "  You need to enter a folder name !\n"
		continue
	fi

	printf "\n"
	printf "  It will create three folders: ~/%s, ~/%s/Apps/Neovim and ~/%s/Dotfiles\n" "$FolderName" "$FolderName" "$FolderName"
	printf "  to get the following folder tree\n\n"
	printf "  /home\n"
	printf "     │\n"
	printf "     └─ %s\n" "$USER"
	printf "        │\n"
	printf "        └─ %s\n" "$FolderName"
	printf "           │\n"
	printf "           └─ Apps\n"
	printf "           │   │\n"
	printf "           │   └─ Neovim install folder\n"
	printf "           │\n"
	printf "           └─ Dotfiles\n"
	printf "               │\n"
	printf "               └─ Neovim config\n"
	printf "\n"
	printf "  Continue with '%s' as folder name ?\n" "$FolderName"
	printf "\n"
	printf "  [y]es, [n]o or [q]uit: "
	read ChoiceFolderName

	case "$ChoiceFolderName" in
		y|yes|Y|YES|YEs|YeS|yeS|yES)
			break
			;;
		n|N|no|NO|No|nO)
			continue
			;;
		*)
			printf "\n"
			printf "  ================================================\n"
			printf "                                                  \n"
			printf "      Nothing has been created and installed.     \n"
			printf "                                                  \n"
			printf "                  See you soon :)                 \n"
			printf "                                                  \n"
			printf "  ================================================\n"
			exit 1
			;;
	esac
done

while true; do
	printf "\n"
	printf "  Please set your neovim username.\n"
	printf "  e.g.: 'FloSlv' will create ~/$FolderName/Apps/Neovim/lua/FloSlv\n"
	printf "\n"
	printf "  Neovim username: "
	read NeovimUsername

	if [ "$NeovimUsername" = "" ]; then
		printf "\n"
		printf "  You need to enter an username to set the neovim config !\n"
		continue
	fi

	printf "\n"
	printf "  It will create the following folder: ~/%s/Apps/Neovim/lua/%s\n" "$FolderName" "$NeovimUsername"
	printf "  to get the following folder tree\n\n"
	printf "  /home\n"
	printf "     │\n"
	printf "     └─ %s\n" "$USER"
	printf "        │\n"
	printf "        └─ %s\n" "$FolderName"
	printf "           │\n"
	printf "           └─ Apps\n"
	printf "           │   │\n"
	printf "           │   └─ Neovim install folder\n"
	printf "           │\n"
	printf "           └─ Dotfiles\n"
	printf "              │\n"
	printf "              └─ neovim\n"
	printf "                 │\n"
	printf "                 └─ lua\n"
	printf "                 │   │\n"
	printf "                 │   └─ %s\n" "$NeovimUsername"
	printf "                 │      │\n"
	printf "                 │      └─ undodir/\n"
	printf "                 │      └─ keymaps.lua\n"
	printf "                 │      └─ options.lua\n"
	printf "                 │      └─ packer.lua\n"
	printf "                 │      └─ utils.lua\n"
	printf "                 │\n"
	printf "                 └─ after\n"
	printf "                    │\n"
	printf "                    └─ plugin\n"
	printf "                       │\n"
	printf "                       └─ plugin config file\n"
	printf "                       └─ plugin config file\n"
	printf "                       └─ ...\n"
	printf "\n"
	printf "  Continue with '%s' as neovim username ?\n" "$NeovimUsername"
	printf "  [y]es, [n]o or [q]uit: "
	read ChoiceNeovimUsername

	case "$ChoiceNeovimUsername" in
		y|yes|Y|YES|YEs|YeS|yeS|yES)
			break
			;;
		n|N|no|NO|No|nO)
			continue
			;;
		*)
			printf "\n"
			printf "  ================================================\n"
			printf "                                                  \n"
			printf "      Nothing has been created and installed.     \n"
			printf "                                                  \n"
			printf "                  See you soon :)                 \n"
			printf "                                                  \n"
			printf "  ================================================\n"
			exit 1
			;;
	esac
done

echo "\n"

BaseFolder="$HOME/$FolderName"
Apps="$HOME/$FolderName/Apps"
Dotfiles="$HOME/$FolderName/Dotfiles"

Neovim="$HOME/$FolderName/Dotfiles/neovim"
Lua="$HOME/$FolderName/Dotfiles/neovim/lua"
NeovimUserFolder="$HOME/$FolderName/Dotfiles/neovim/lua/$NeovimUsername"
Undodir="$HOME/$FolderName/Dotfiles/neovim/lua/$NeovimUsername/undodir"
After="$HOME/$FolderName/Dotfiles/neovim/after"
AfterPlugin="$HOME/$FolderName/Dotfiles/neovim/after/plugin"

if [ -d "$Neovim" ]; then
	printf "  ================================================\n"
	printf "                                                  \n"
	printf "   Directory ~/%s/Apps/Neovim already exists !    \n" "$FolderName"
	printf "                                                  \n"
	printf "     Please delete it then re run this script.    \n"
	printf "                                                  \n"
	printf "      Nothing has been created and installed.     \n"
	printf "                                                  \n"
	printf "                  See you soon :)                 \n"
	printf "                                                  \n"
	printf "  ================================================\n"
	printf "\n"
	exit 1
elif [ -d "$BaseFolder" ] && [ ! -d "$Apps" ]; then
	mkdir $Apps
	printf "=== %s created ! ===\n" "$Apps"
elif [ -d "$BaseFolder" ] && [ ! -d "$Dotfiles" ]; then
	mkdir $Dotfiles
	printf "=== %s created ! ===\n" "$Dotfiles"
	printf "\n"
	mkdir $Neovim
	printf "=== %s created ! ===\n" "$Neovim"
	printf "\n"
	mkdir $Lua
	printf "=== %s created ! ===\n" "$Lua"
	printf "\n"
	mkdir $NeovimUserFolder
	printf "=== %s created ! ===\n" "$NeovimUserFolder"
	printf "\n"
	mkdir $Undodir
	printf "=== %s created ! ===\n" "$Undodir"
	printf "\n"
	mkdir $After
	printf "=== %s created ! ===\n" "$After"
	printf "\n"
	mkdir $AfterPlugin
	printf "=== %s created ! ===\n" "$AfterPlugin"
else
	mkdir $BaseFolder
	printf "=== %s created ! ===\n" "$BaseFolder"
	printf "\n"
	mkdir $Apps
	printf "=== %s created ! ===\n" "$Apps"
	printf "\n"
	mkdir $Dotfiles
	printf "=== %s created ! ===\n" "$Dotfiles"
	printf "\n"
	mkdir $Neovim
	printf "=== %s created ! ===\n" "$Neovim"
	printf "\n"
	mkdir $Lua
	printf "=== %s created ! ===\n" "$Lua"
	printf "\n"
	mkdir $NeovimUserFolder
	printf "=== %s created ! ===\n" "$NeovimUserFolder"
	printf "\n"
	mkdir $Undodir
	printf "=== %s created ! ===\n" "$Undodir"
	printf "\n"
	mkdir $After
	printf "=== %s created ! ===\n" "$After"
	printf "\n"
	mkdir $AfterPlugin
	printf "=== %s created ! ===\n" "$AfterPlugin"
fi

printf "\n"
printf "=== apt update ===\n"
printf "\n"
cd ~
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
printf "=== install dependencies ===\n"
printf "\n"
sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake \
cmake g++ pkg-config doxygen zoxide python3-pip mlocate libsqlite3-dev \
libssl-dev ripgrep fd-find silversearcher-ag bat libicu-dev libboost-all-dev
printf "=== git clone nvim-release-0.8 ===\n"
printf "\n"
cd $Apps
git clone -b release-0.8 https://github.com/neovim/neovim Neovim
cd Neovim
printf "=== make ===\n"
printf "\n"
make CMAKE_BUILD_TYPE=RelWithDebInfo
printf "=== make install ===\n"
printf "\n"
sudo make install
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
cd ~
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

# Tree-sitter-cli (node.js)
printf "\n"
printf "=================================\n"
printf "    INSTALLING TREE-SITER-CLI    \n"
printf "             node.js             \n"
printf "=================================\n"
printf "\n"
cd ~
npm i -g tree-sitter-cli
printf "\n"
printf "==================================\n"
printf "    TREE-SITER-CLI INSTALLED !    \n"
printf "==================================\n"
printf "\n"

# Neovim-cli (node.js)
printf "\n"
printf "=============================\n"
printf "    INSTALLING NEOVIM-CLI    \n"
printf "            node.js          \n"
printf "=============================\n"
printf "\n"
cd ~
npm i -g neovim
printf "\n"
printf "==============================\n"
printf "    NEOVIM-CLI INSTALLED !    \n"
printf "==============================\n"
printf "\n"

# Neovim config
printf "\n"
printf "=====================\n"
printf "    NEOVIM CONFIG    \n"
printf "=====================\n"
printf "\n"
printf "=== install config files ===\n"
printf "\n"
wget -P $NeovimUserFolder -O options.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/options.lua
wget -P $NeovimUserFolder -O keymaps.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/keymaps.lua
wget -P $NeovimUserFolder -O utils.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/utils.lua
wget -P $NeovimUserFolder -O packer.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/packer.lua
wget -P $Neovim -O init.lua https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/init.lua
printf "=== install plugins config file ===\n"
printf "\n"
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/colorscheme.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/colorful-winsep.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/comment.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/dashboard.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/gitsigns.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/glow.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/indent-blankline.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/lsp.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/lualine.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/luasnip.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/nvim-autopairs.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/nvim-cmp.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/nvim-colorizer.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/nvim-notify.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/nvim-tree.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/nvim-treesitter.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/nvim-web-devicons.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/rust-tools.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/telescope.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/vim-dadbod-ui.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/vim-illuminate.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/vimade.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/which-key.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/wilder.lua
wget -P $AfterPlugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/winbar.lua
printf "\n"
printf "===============================\n"
printf "    NEOVIM CONFIG INSTALLED    \n"
printf "===============================\n"

# Stow
printf "\n"
printf "========================================\n"
printf "    SYMBOLIC LINKS TO ~/.config/nvim    \n"
printf "========================================\n"
printf "\n"
cd $HOME/.config
mkdir nvim
cd $Dotfiles
stow -t $HOME/.config/nvim neovim
printf "\n"
printf "=============================\n"
printf "    SYMBOLIC LINKS DONE !    \n"
printf "=============================\n"

# Neovim version
printf "\n"
printf "=== neovim version ===\n"
printf "\n"
nvim --version
