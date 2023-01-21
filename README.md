# How I manage my dotfiles

### Purpose

The idea is to keep all my dotfiles in the same folder.<br>
In this way, I can easily manage it with git / github to install it in a new computer.<br><br>

Moreover, I don't really like how Linux organize all dotfiles and apps installation. If you look into your `$HOME` folder, some of them are in `~/.config` directory, others in their own folder, and others like `.zshrc` in the `$HOME` directly.<br><br>

I use **Ubuntu 22.04.1 LTS** as an operating system.<br>
I use **i3** as a window manager.<br>
I use **TMUX** as a terminal multiplexer.<br>
I use **NEOVIM** as an editor.<br><br>

My workflow is pretty basic and I tend to not use my mouse. Even in Firefox thanks to the Vimium extension !
<br><br>

So, in the end, I created a simple folder called `Flo` in my `$HOME`.<br>
Inside it, there is my `Dotfiles` directory and all other folders I use every day. Everything is clean and my mind is in peace xD<br><br>

To deal with that and keep my dotfiles in the same folder, I use `stow`, which is a symlink manager.<br><br>

Here is the process if you want the same environment ! 🚀<br><br><br />

# Development Environment

:warning: _January 2023_ :warning:<br />
► only tested and approved on:

- Ubuntu 22.04.1 LTS x86_64
- Virtual Box VM - Ubuntu 22.04.1 LTS x86_64
  <br /><br />

At first, this repo was for my own usage but I tried to comment every step so you can follow my instructions and take inspiration from my repo :blush:

I assume you start with a fresh installation of Ubuntu 22.04.1 LTS

I also assume you know basics of VIM like how to edit and save/quit :stuck_out_tongue_closed_eyes:

Each step respect a specific order. Please respect same order !

The complete installation take around ~60 min depending power of the computer and your knowledges to understand what I am doing.

---

1. Dependencies

   1. [Folder structure](#create-folder-structure)
   2. [Install packages](#install-dependencies)

2. [Oh-my-zsh](#oh-my-zsh---install)

3. More dependencies

   1. [Node.js via nvm](#nodejs-via-nvm---install)
   2. [Rust and Cargo](#rust---install)

4. Neovim

   1. First option: install and config Neovim from [flo-neovim-install.sh](#first-option-install-and-config-neovim-from-a-bash-script)
   2. Second option:
      1. [Install from sources](#second-option-neovim---install-from-sources)
      2. [Packer as plugin management](#packer---install)
      3. [Neovim config](#neovim---config)

5. Tmux

   1. [Install from sources](#tmux---install-from-sources)
   2. [Tmux config](#tmux---config)

6. [zsh config](#zsh---config)

7. [Alacritty](#alacritty---install) as terminal

8. [Hack Nerd Font](#hack-font---install)

9. [Starship](#starship---install) custom zsh prompt

10. [fzf](#fzf---install)

11. [Rofi](#rofi---config)

12. [Polybar](#polybar---install-and-config)

13. [I3wm](#i3-wm---config) as windows manager

14. [Btop](#btop---install)

15. Git

    1. [Git config](#git---config)
    2. [Git CZ](#git-cz---install-and-config)
    3. [GitUI](#gitui---install-and-config)

16. [Insomnia](#insomnia---install)

17. [Notion](#notion---install)

18. [MongoDB Compass](#mongodb-compass---install)

19. [Glow](#glow---install)

20. [SSH](#ssh---github-keys)

21. [~/Flo/Dotfiles as git repo](#flodotfiles-as-git-repo)

22. [AppImageLauncher](#appimagelauncher---install)

23. [PrismaStudio](#prisma-studio---install)

---

<br />

## If you install Ubuntu with VirtualBox

Here is few more steps if you start a fresh Ubuntu install with VirtualBox.

Log in as root user.

```sh
su
```

Add your user to 'sudo' group. In my case, my user is called 'flo'.

```sh
sudo usermod -a -G sudo flo
```

Install `sudo` package

```sh
apt install sudo
```

If you still have an issue like `you user is not in the sudoers file...`, you need to add manually your user.

```sh
su
```

```sh
sudo visudo
```

Write this line just after `Root ALL=(ALL:ALL) ALL`.

```sh
flo ALL=(ALL:ALL) ALL
```

Close your terminal and re open-it.

<br />

Update/Upgrade packages, update snap packages and delete pre-install useless games, programs and tools.<br />
You need to close Firefox first and run those commands.

```sh
sudo apt update && \
sudo apt upgrade -y && \
sudo snap refresh firefox snapd snapd-desktop-integration && \
sudo apt remove -y thunderbird rhythmbox simple-scan shotwell remmina libreoffice-impress libreoffice-draw cheese \
aisleriot gnome-sudoku gnome-mines gnome-mahjongg gnome-todo gnome-todo-common && \
sudo apt autoremove -y && \
sudo apt autoclean -y
```

You also need to update version of `core` and version of `gnome` by going to Ubuntu Software tool (aka Snap Store).

To update `snap-store` itself, you need to first kill his process, then run `sudo snap refresh snap-store`.

<br /><br /><br />

## Create folder structure

```sh
mkdir ~/Flo ~/Flo/Dev ~/Flo/Downloads ~/Flo/Apps ~/Flo/Dotfiles && \
rm -rf ~/Desktop ~/Videos ~/Templates ~/Public ~/Pictures ~/Music ~/Downloads ~/Documents
```

<br /><br /><br />

## Install dependencies

```sh
sudo apt update && \
sudo apt upgrade -y && \
sudo apt install -y git zsh zsh-syntax-highlighting curl i3 rofi compton \
tree ripgrep fd-find silversearcher-ag unzip bat python3-dev \
neofetch stow mlocate zoxide python3-pip libsqlite3-dev \
libssl-dev wget && \
sudo apt autoremove -y && \
sudo apt autoclean -y
```

<br /><br /><br />

## OH-MY-ZSH - install

https://ohmyz.sh/#install

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Close terminal.<br />
Logout then login.<br />
Open terminal.

<br />

Create needed folder and files, install custom theme `ys-flo.zsh-theme` and install plugins `zsh-autosuggestions` and `zsh-syntax-highlighting`.<br />
https://github.com/Flo-Slv/Dotfiles/blob/main/oh-my-zsh/ys-flo.zsh-theme<br />
https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh<br />
https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md

```sh
mkdir -p ~/Flo/Dotfiles/oh-my-zsh && \
wget -P ~/.oh-my-zsh/custom/themes https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/oh-my-zsh/ys-flo.zsh-theme && \
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
mv ~/.oh-my-zsh ~/Flo/Dotfiles/oh-my-zsh && \
cd ~/Flo/Dotfiles && \
stow -t ~/ oh-my-zsh
```

<br /><br /><br />

## NODE.JS via NVM - install

https://github.com/nvm-sh/nvm#installing-and-updating

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

Close and re open terminal.

```sh
nvm install 18 && \
nvm install 16 && \
nvm use 18
```

Again, close and re open terminal.

<br /><br /><br />

## RUST - install

https://www.rust-lang.org/tools/install

```sh
cd ~ && \
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

<br />
Close and re open terminal.

<br /><br /><br />

## First option: install and config NEOVIM from a bash script

https://github.com/Flo-Slv/Dotfiles/blob/main/flo-neovim-install.sh

I developed a script who will create the needed folder structure and install/config Neovim.

Warning: this script only run on Linux (sorry for users of Windows and Mac OS) and only if you have Node.js installed.

```sh
wget -P ~/ https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/flo-neovim-install.sh && \
chmod +x ~/flo-neovim-install.sh
```

```sh
cd ~ && ./flo-neovim-install.sh
```

Open `packer.lua`.

```sh
nvim ~/Flo/Dotfiles/neovim/lua/FloSlv/packer.lua
```

Then run this command: `:PackerSync`

Save and close: `:wq`

Re open `packer.lua`

```sh
nvim ~/Flo/Dotfiles/neovim/lua/FloSlv/packer.lua
```

And wait for LSP servers installation and Treesitter parsers installation.

You have to run `:Mason` to be sure that every LSP server is correctly installed.

You can also run `:TSUpdate` to be sure that every Treesitter parsers is installed.

<br /><br /><br />

## Second option: NEOVIM - install from sources

https://github.com/neovim/neovim/wiki/Building-Neovim

1. Install dependencies

```sh
cd ~ && \
sudo apt install -y ninja-build gettext libtool libtool-bin autoconf python3-dev \
automake cmake g++ pkg-config doxygen libicu-dev libboost-all-dev libssl-dev \
ripgrep fd-find silversearcher-ag mlocate zoxide python3-pip libsqlite3-dev bat
```

<br />

2. Clone Neovim repository

```sh
git clone -b release-0.8 https://github.com/neovim/neovim ~/Flo/Apps/Neovim
```

<br />

3. Compile sources

```sh
cd ~/Flo/Apps/Neovim && \
make CMAKE_BUILD_TYPE=RelWithDebInfo && \
sudo make install
```

<br /><br /><br />

## PACKER - install

https://github.com/wbthomason/packer.nvim

```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

<br /><br /><br />

## NEOVIM - config

1. PYNVIM - install

https://github.com/neovim/pynvim<br />
We need it for some Neovim's plugins.

```sh
cd ~ && \
pip3 install pynvim
```

<br />

2. Create folders

IMPORTANT: Replace `FloSlv` by your user name.

```sh
mkdir ~/.config/nvim && \
mkdir -p ~/Flo/Dotfiles/neovim/lua && \
mkdir -p ~/Flo/Dotfiles/neovim/after/plugin && \
mkdir -p ~/Flo/Dotfiles/neovim/after/ftplugin && \
mkdir -p ~/Flo/Dotfiles/neovim/lua/FloSlv/undodir
```

<br />

3. Add config<br />

Create `options.lua`, `keymaps.lua`, `utils.lua`, `packer.lua` and `init.lua`.<br />
https://github.com/Flo-Slv/Dotfiles/blob/main/neovim/lua/FloSlv/options.lua<br />
https://github.com/Flo-Slv/Dotfiles/blob/main/neovim/lua/FloSlv/keymaps.lua<br />
https://github.com/Flo-Slv/Dotfiles/blob/main/neovim/lua/FloSlv/utils.lua<br  />
https://github.com/Flo-Slv/Dotfiles/blob/main/neovim/lua/FloSlv/packer.lua<br />
https://github.com/Flo-Slv/Dotfiles/blob/main/neovim/init.lua

```sh
wget -P ~/Flo/Dotfiles/neovim/lua/FloSlv https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/options.lua && \
wget -P ~/Flo/Dotfiles/neovim/lua/FloSlv https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/keymaps.lua && \
wget -P ~/Flo/Dotfiles/neovim/lua/FloSlv https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/utils.lua && \
wget -P ~/Flo/Dotfiles/neovim/lua/FloSlv https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/packer.lua && \
wget -P ~/Flo/Dotfiles/neovim https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/init.lua
```

<br />

NB: You don't need the next two files: `autosave.lua` and `autorun.lua`.
They are related to my personal projects in Rust and they are not stable and relevent for you.

Create `autosave.lua` and `autorun.lua`.<br />
https://github.com/Flo-Slv/Dotfiles/blob/main/neovim/lua/FloSlv/autosave.lua<br />
https://github.com/Flo-Slv/Dotfiles/blob/main/neovim/lua/FloSlv/autorun.lua

```sh
wget -P ~/Flo/Dotfiles/neovim/lua/FloSlv https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/autosave.lua && \
wget -P ~/Flo/Dotfiles/neovim/lua/FloSlv https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/lua/FloSlv/autorun.lua
```

<br />

4. Set up all plugins

```sh
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/autopairs.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/colorscheme.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/colorful-winsep.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/comment.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/dashboard.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/gitsigns.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/glow.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/indent-blankline.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/lsp.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/lualine.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/luasnip.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/null-ls.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/nvim-autopairs.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/nvim-cmp.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/nvim-colorizer.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/nvim-notify.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/nvim-tree.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/nvim-treesitter.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/nvim-web-devicons.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/rust-tools.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/tailwindcss-colorizer-cmp.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/telescope.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/todo-comments.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/trouble.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/undotree.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/vim-dadbod-ui.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/vim-illuminate.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/vimade.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/which-key.lua && \
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/wilder.lua &&\
wget -P ~/Flo/Dotfiles/neovim/after/plugin https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/neovim/after/plugin/winbar.lua
```

<br />

5. Node.js required packages

Check if you already have Tree-Sitter and Neovim node.js package installed.

```sh
npm list -g
```

If not, you can easily install it.

```sh
npm i -g tree-sitter-cli && \
npm i -g neovim
```

<br />

6. Stow

```sh
cd ~/Flo/Dotfiles && \
stow -t ~/.config/nvim neovim
```

<br />

7. Last step

Open `packer.lua`.

```sh
nvim ~/Flo/Dotfiles/neovim/lua/FloSlv/packer.lua
```

Then run this command: `:PackerSync`

Save and close: `:wq`

Re open `packer.lua`

```sh
nvim ~/Flo/Dotfiles/neovim/lua/FloSlv/packer.lua
```

And wait for LSP servers installation and Treesitter parsers installation.

You have to run `:Mason` to be sure that every LSP server is correctly installed.

You can also run `:TSUpdate` to be sure that every Treesitter parsers is installed.

<br /><br /><br />

## TMUX - install from sources

1. Update packages and remove existing Tmux package.

```sh
cd ~ && \
sudo apt update && \
sudo apt upgrade -y && \
sudo apt remove tmux && \
sudo apt autoremove -y && \
rm -rf .tmux
```

<br />

2. Install prerequisite libraries

```sh
sudo apt install -y libevent-dev ncurses-dev build-essential bison
```

<br />

3. Fetch Tmux from Git repo

```sh
git clone https://github.com/tmux/tmux.git ~/Flo/Apps/Tmux
```

<br />

4. Compile sources

```sh
cd ~/Flo/Apps/Tmux && \
sh autogen.sh && \
./configure && \
make && \
sudo make install
```

<br />

5. Check version of Tmux

```sh
tmux -V
```

<br /><br />

## TMUX - config

1. Create `.tmux` and `tmux-powerline-custom-themes` folders.

```sh
mkdir -p ~/Flo/Dotfiles/tmux/.tmux && \
mkdir -p ~/Flo/Dotfiles/tmux/.tmux/tmux-powerline-custom-themes
```

<br />

2. Clone TMUX Plugin Manager and TMUX Powerline.

```sh
git clone https://github.com/tmux-plugins/tpm ~/Flo/Dotfiles/tmux/.tmux/plugins/tpm && \
git clone https://github.com/erikw/tmux-powerline.git ~/Flo/Dotfiles/tmux/.tmux/plugins/tmux-powerline
```

<br />

3. Fetch `.tmux.conf`, `.tmux-powerlinerc` and `flo-theme.sh` files from my GitHub repo.

https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/tmux/.tmux.conf<br />
https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/tmux/.tmux.powerlinerc<br />
https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/tmux/.tmux/tmux-powerline-custom-themes/flo-theme.sh

```sh
wget -P ~/Flo/Dotfiles/tmux https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/tmux/.tmux.conf && \
wget -P ~/Flo/Dotfiles/tmux https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/tmux/.tmux.powerlinerc && \
wget -P ~/Flo/Dotfiles/tmux/.tmux/tmux-powerline-custom-themes https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/tmux/.tmux/tmux-powerline-custom-themes/flo-theme.sh
```

<br />

4. Add my custom `flo-theme.sh` as `default.sh` theme for tmux-powerline.

```sh
mv ~/Flo/Dotfiles/tmux/.tmux/plugins/tmux-powerline/themes/default.sh ~/Flo/Dotfiles/tmux/.tmux/plugins/tmux-powerline/themes/default.sh.old && \
ln -s ~/Flo/Dotfiles/tmux/.tmux/tmux-powerline-custom-themes/flo-theme.sh ~/Flo/Dotfiles/tmux/.tmux/plugins/tmux-powerline/themes/default.sh
```

<br />

5. Stow

```sh
cd ~/Flo/Dotfiles && \
stow -t ~/ tmux
```

<br />

Close and re open terminal.

<br />

6. Open `.tmux.conf`, install plugins and reload TMUX.

```sh
tmux
```

```sh
nvim ~/Flo/Dotfiles/tmux/.tmux.conf
```

```sh
# ctrl+z I to install plugins
# ctrl+z r to re source tmux
# Save/close
```

<br />

Close Tmux then close and re open terminal.

<br /><br /><br />

## ZSH - config

Create `.zshrc`.<br />
https://github.com/Flo-Slv/Dotfiles/blob/main/zsh/.zshrc<br />

```sh
rm -rf ~/.zshrc && \
mkdir -p ~/Flo/Dotfiles/zsh && \
wget -P ~/Flo/Dotfiles/zsh https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/zsh/.zshrc && \
mv ~/.zshenv ~/Flo/Dotfiles/zsh && \
cd ~/Flo/Dotfiles && \
stow -t ~/ zsh
```

<br />

Close terminal and re open it.

PS: do not copy/paste if you don't understand. You need to adapt with your own aliases, tmux panes sizes etc...

<br /><br /><br />

## Alacritty - install

https://github.com/alacritty/alacritty

Install

```sh
cd ~ && \
git clone https://github.com/alacritty/alacritty.git ~/Flo/Apps/Alacritty && \
rustup override set stable && \
rustup update stable && \
sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 && \
cd ~/Flo/Apps/Alacritty && \
cargo build --release
```

To have Desktop icon

```sh
cd ~/Flo/Apps/Alacritty && \
sudo cp target/release/alacritty /usr/local/bin && \
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg && \
sudo desktop-file-install extra/linux/Alacritty.desktop && \
sudo update-desktop-database
```

To have manual page

```sh
cd ~/Flo/Apps/Alacritty && \
sudo mkdir -p /usr/local/share/man/man1 && \
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null && \
gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
```

Config

```sh
cd ~ && \
mkdir -p ~/.config/alacritty && \
mkdir -p ~/Flo/Dotfiles/alacritty && \
wget -P ~/Flo/Dotfiles/alacritty https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/alacritty/alacritty.yml && \
cd ~/Flo/Dotfiles && \
stow -t ~/.config/alacritty alacritty
```

<br />

Close terminal and open Alacritty terminal.

<br />

To get emoji on Alacritty terminal.
```sh
cd ~ && \
sudo apt install -y fonts-noto-color-emoji && \
mkdir -p ~/.config/fontconfig && \
mkdir -p ~/Flo/Dotfiles/fontconfig && \
wget -P ~/Flo/Dotfiles/fontconfig https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/fontconfig/fonts.conf && \
cd ~/Flo/Dotfiles && \
stow -t ~/.config/fontconfig fontconfig
```

<br />

Close and re open Alacritty terminal.

<br /><br /><br />

## KITTY - install

I was using Kitty but due to some performance issues I switched to Alacritty (dev in Rust).<br />
You can still use Kitty if you want. Here is how to install/configure it.

https://sw.kovidgoyal.net/kitty/binary/

```sh
cd ~ && \
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

A new terminal has opened, close it for now.

<br />

Create `kitty.conf`<br />
Download this file as 'kitty.conf': https://github.com/Flo-Slv/Dotfiles/blob/main/kitty/kitty.conf

```sh
mkdir -p ~/Flo/Dotfiles/kitty && \
wget -P ~/Flo/Dotfiles/kitty https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/kitty/kitty.conf && \
cd ~/Flo/Dotfiles && \
stow -t ~/.config/kitty kitty
```

<br />

To have desktop icons etc...

```sh
cd ~/.local && mkdir bin && ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/ && \
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/ && \
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/ && \
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop && \
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
```

<br />

Close terminal and open Kitty terminal.

<br /><br /><br />

## HACK FONT - install

Go to https://www.nerdfonts.com/font-downloads to check if link is the lastest release version !

```sh
wget -P ~/Flo/Downloads https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/Hack.zip && \
cd ~/.local/share && \
mkdir fonts && \
cd fonts && \
mv ~/Flo/Downloads/Hack.zip . && \
unzip Hack.zip && \
rm -rf Hack.zip
```

<br />

Close and re open Alacritty terminal.
<br /><br />

Check if Hack Nerd Font have been installed correctly.

On Alacritty
```sh
fc-list | grep -i "Hack"
```

Or on Kitty
```sh
kitty +list-fonts
```

<br />

Optional: to have Hack Nerd Font available in Polybar.

```sh
sudo mkdir /usr/share/fonts/truetype/hack-nerd-font && \
sudo cp ~/.local/share/fonts/Hack\ Regular\ Nerd\ Font\ Complete.ttf /usr/share/fonts/truetype/hack-nerd-font/
```

<br /><br /><br />

## Starship - install

https://github.com/starship/starship

```sh
cd ~/ && \
curl -sS https://starship.rs/install.sh | sh
```

```sh
mkdir ~/Flo/Dotfiles/starship && \
wget -P ~/Flo/Dotfiles/starship https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/starship/starship.toml && \
cd ~/Flo/Dotfiles && \
stow -t ~/.config starship
```

Close terminal and re open it.

<br /><br /><br />

## fzf - install

https://github.com/junegunn/fzf

```sh
git clone https://github.com/junegunn/fzf ~/.fzf && \
cd ~/.fzf && ./install
```

<br />

Close terminal and re open it.

<br /><br /><br />

## ROFI - config

```sh
mkdir ~/.config/rofi && \
mkdir -p ~/Flo/Dotfiles/rofi && \
wget -P ~/Flo/Dotfiles/rofi https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/rofi/config.rasi && \
wget -P ~/Flo/Dotfiles/rofi https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/rofi/flo-theme.rasi && \
cd ~/Flo/Dotfiles && \
stow -t ~/.config/rofi rofi
```

<br /><br /><br />

## POLYBAR - install and config

1. Install from sources
   https://github.com/polybar/polybar/wiki/Compiling

```sh
cd ~/ && \
sudo apt update && \
sudo apt upgrade -y && \
sudo apt install -y git cmake build-essential cmake-data pkg-config python3-sphinx \
libuv1-dev libcairo2-dev libxcb1-dev libcurl4-openssl-dev libnl-genl-3-dev \
libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen \
xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev \
libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm \
libjsoncpp-dev libmpdclient-dev python3-packaging && \
sudo apt autoremove -y
```

<br />

Go to https://github.com/polybar/polybar/releases to check if link is the last release version.

```sh
wget -P ~/Flo/Downloads https://github.com/polybar/polybar/releases/download/3.6.3/polybar-3.6.3.tar.gz && \
cd ~/Flo/Downloads && \
tar xvzf polybar-3.6.3.tar.gz && \
rm -rf polybar-3.6.3.tar.gz
```

```sh
mv polybar-3.6.3 ~/Flo/Apps/Polybar-3.6.3 && \
cd ~/Flo/Apps/Polybar-3.6.3 && \
mkdir build && \
cd build
```

```sh
cmake .. && \
make -j$(nproc) && \
sudo make install
```

<br />

Create all necessaries folder and files.

```sh
mkdir ~/.config/polybar && \
mkdir ~/Flo/Dotfiles/polybar && \
wget -P ~/Flo/Dotfiles/polybar https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/polybar/polybar.sh && \
chmod +x ~/Flo/Dotfiles/polybar/polybar.sh && \
wget -P ~/Flo/Dotfiles/polybar https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/polybar/config.ini && \
cd ~/Flo/Dotfiles && \
stow -t ~/.config/polybar polybar
```

<br />

Install font-awesome

```sh
cd ~ && \
sudo apt install -y fonts-font-awesome
```

<br /><br /><br />

## I3-WM - config

```sh
mkdir ~/.config/i3 && \
mkdir -p ~/Flo/Dotfiles/i3 && \
wget -P ~/Flo/Dotfiles/i3 https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/i3/config && \
cd ~/Flo/Dotfiles && \
stow -t ~/.config/i3 i3
```

<br />

Close Kitty.<br />
Close all others windows.<br />
Restart Ubuntu.<br />
Choose i3 as windows manager.<br />
Login.

<br /><br /><br />

## BTOP - install

https://github.com/aristocratos/btop#installation

Download latest release (x86_64-linux-musl version in my case) into `~/Flo/Downloads`.

Go to https://github.com/aristocratos/btop/releases to check if link is the lastest release version.

```sh
wget -P ~/Flo/Downloads https://github.com/aristocratos/btop/releases/download/v1.2.13/btop-x86_64-linux-musl.tbz && \
cd ~/Flo/Apps && \
mkdir Btop && \
mv ~/Flo/Downloads/btop-x86_64-linux-musl.tbz ~/Flo/Apps/Btop && \
cd ~/Flo/Apps/Btop && \
tar -xjf btop-x86_64-linux-musl.tbz && \
rm btop-x86_64-linux-musl.tbz && \
cd btop && sudo make install
```

<br />

Close and re open terminal.

<br /><br /><br />

## GIT - config

Just copy/paste those lines into your terminal but change your email and name before type Enter !

```sh
mkdir -p ~/Flo/Dotfiles/git && \
touch ~/Flo/Dotfiles/git/.gitconfig && \
cat << EOF >> ~/Flo/Dotfiles/git/.gitconfig
[user]
    email = {your-email}
    name = {your-name}
[core]
    editor = nvim
EOF
```

```sh
cd ~/Flo/Dotfiles && \
stow -t ~/ git
```

<br /><br /><br />

## GIT-CZ - install and config

https://github.com/streamich/git-cz

```sh
cd ~ && \
npm install -g git-cz
```

<br />

Create `changelog.config.js`

```sh
wget -P ~/Flo/Dotfiles/git https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/git/changelog.config.js && \
cd ~/Flo/Dotfiles && \
stow -t ~/ git
```

<br /><br /><br />

## GITUI - install and config

1. Install GitUI

https://github.com/extrawurst/gitui#build

```sh
cargo install gitui
```

<br />

2. Configure GitUI

```sh
mkdir ~/.config/gitui && \
mkdir -p ~/Flo/Dotfiles/gitui && \
wget -P ~/Flo/Dotfiles/gitui https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/gitui/theme.ron && \
wget -P ~/Flo/Dotfiles/gitui https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/gitui/key_bindings.ron && \
cd ~/Flo/Dotfiles && \
stow -t ~/.config/gitui gitui
```

<br /><br /><br />

## INSOMNIA - install

https://docs.insomnia.rest/insomnia/install

```sh
echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" | sudo tee -a /etc/apt/sources.list.d/insomnia.list
```

```sh
sudo apt update && \
sudo apt install -y insomnia && \
sudo apt autoremove -y
```

<br />

Close terminal.
Logout then login.

<br />

You can install plugins in Insomnia: tokyonight theme, gist integration and os infos.
<br /><br /><br />

## NOTION - install

https://notion-enhancer.github.io/getting-started/installation/

```sh
echo "deb [trusted=yes] https://apt.fury.io/notion-repackaged/ /" | sudo tee /etc/apt/sources.list.d/notion-repackaged.list && \
sudo apt update && \
sudo apt install -y notion-app-enhanced && \
sudo apt autoremove -y
```

<br /><br /><br />

## MONGODB COMPASS - install
https://www.mongodb.com/try/download/compass

Download the last stable version for Ubuntu 16.04+ (.deb file).

1.35.0 as I wrote this line (January 2023).

```sh
cd ~/Flo/Downloads && \
sudo dpkg -i mongodb-compass_1.35.0_amd64.deb
```

<br />

You maybe will need to run this command to fix issue after installing Mongo DB Compass.
```sh
sudo apt --fix-broken install
```

<br /><br /><br />

## GLOW - install

https://github.com/charmbracelet/glow

```sh
sudo mkdir -p /etc/apt/keyrings && \
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg && \
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list && \
sudo apt update && sudo apt install -y glow && sudo apt autoremove -y
```

<br /><br /><br />

## SSH - github keys

https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

```sh
cd ~/.ssh && \
ssh-keygen -t ed25519 -C "your_email@example.com"
```

```sh
eval "$(ssh-agent -s)"
```

```sh
ssh-add ~/.ssh/id_ed25519
```

<br />

https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account

```sh
cat ~/.ssh/id_ed25519.pub
```

Copy/paste to GitHub.
<br /><br />

Add an alias into `~/.zshrc`<br />

```sh
nvim ~/.zshrc
```

```sh
# Add Github key to SSH agent.
alias sa="eval `ssh-agent`"
alias ss="ssh-add ~/.ssh/id_ed25519"
```

<br /><br /><br />

## ~/Flo/Dotfiles as git repo

https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories

1. Initialize `Dotfiles` folder as a git repo and add `Dotfiles` github remote repo.

```sh
cd ~/Flo/Dotfiles && \
git init && \
git remote add origin git@github.com:Flo-Slv/Dotfiles.git && \
git checkout -b main
```

 <br />

3. Remove and pull from remote

```sh
cd ~/Flo/Dotfiles && \
rm -rf alacritty/ git/ gitui/ kitty/ neovim/ i3/ polybar/ rofi/ starship/ zsh/ tmux/.tmux.conf tmux/.tmux.powerlinerc tmux/.tmux/tmux-powerline-custom-themes/ && \
git pull origin main
```

<br /><br /><br />

## AppImageLauncher - install

https://github.com/TheAssassin/AppImageLauncher<br />
If you need to install an AppImage, you can install a launcher for AppImage.<br />
It will be easier for you to handle install/config of AppImages.

```sh
sudo apt install software-properties-common && \
sudo add-apt-repository ppa:appimagelauncher-team/stable && \
sudo apt update && \
sudo apt install -y appimagelauncher && \
sudo apt autoremove -y
```

<br />

If you run AppImageLauncher, you can define where to save AppImages.

<br /><br /><br />

## Prisma Studio - install

https://github.com/prisma/studio

If you don't want to use Mongo DB Compass, you can instead use Prisma Studio.

You will need to install AppImageLauncher first (see above).

Then download the latest `Prisma-Studio.AppImage` release.<br />
https://github.com/prisma/studio/releases

You can now easily install Prisma Studio thanks to AppImageLauncher.

<br /><br /><br />

## STOW

https://linux.die.net/man/8/stow

Here is basics usages

```sh
# Specify the target with -t parameter.
# Example with the i3 directory:
cd ~/Flo/Dotfiles/i3wm/i3
stow -t ~/.config i3

# "Unstow" with -D parameter.
cd ~/Flo/Dotfiles/i3wm/i3
stow -t ~/.config -D i3
```

If you need more info: `stow --help`

<br /><br /><br />

### Special aliases for my laptop - in sudo mod

```sh
alias ffull='echo 255 > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon[[:print:]]*/pwm1'
alias fmedium='echo 150 > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon[[:print:]]*/pwm1'
alias fsmall='echo 100 > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon[[:print:]]*/pwm1'
alias fstop='echo 0 > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon[[:print:]]*/pwm1'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
```

<br /><br />

### Some cool commands that can help !

```sh
# To know shell we use (2 options)
# First option
echo $SHELL

# Second option
ls -l /proc/$$/exe

# To know terminal we use
echo $TERM

# To check if terminal is truecolor
echo $COLORTERM

# To have more info on Terminal
ps -o 'cmd=' -p $(ps -o 'ppid=' -p $$)

# To see all env variables
printenv
```
