# Dotfiles

### Purpose
The idea is to keep all my dotfiles in the same folder.<br>
In this way, I can easily manage it with git / github to install it in a new computer.<br><br>

Moreover, I don't really like how Linux organize all dotfiles and apps installation. If you look into your `$HOME` folder, some of them are in `~/.config` directory, others in their own folder, and others like `.vimrc` in the `$HOME` directly.<br><br>

I use **Ubuntu 22.04 LTS** as an operating system.<br>
I use **i3** as a window manager.<br>
I use **TMUX** as a terminal multiplexer.<br>
I use **NEOVIM** as an editor.<br><br>

My workflow is pretty basic and I tend to not use my mouse. Even in Brave or Firefox thanks to the Vimium extension !
<br><br>

So, in the end, I created a simple folder called `Flo` in my `$HOME`.<br>
Inside it, there is my `Dotfiles` directory and folders I use every day. Everything is clean and my mind is in peace xD<br><br>

To deal with that and keep my dotfiles in the same folder, I use `stow`, which is a symlink manager.<br><br>

Here is the process if you want the same environment !<br><br><br />

# Development Environment

:warning: *August 2022* :warning:<br />
► only tested and approved on Ubuntu 22.04 LTS x86_64 + on Virtual Box VM - Ubuntu 22.04 LTS x86_64
<br /><br />

It's for my own usage but you can follow my instructions and take inspiration from my repo :blush:

---

- Zsh with Oh-my-zsh
- Kitty as terminal
- Hack Nerd Font as main font
- Starship custom prompt
- i3 as windows manager
- Polybar
- Rofi
- Tmux
- Neovim with Packer as plugin management
- Git with GitUI and git-cz
- Nvm for Node.js and npm
- Rust and Cargo
- Notion
- Insomnia
- Btop
- Stow
- Discord

---

I assume you start with a fresh installation of Ubuntu 22.04 LTS<br />
I also assume you know basics of VIM like how to edit and save/quit :stuck_out_tongue_closed_eyes:

Each step respect a specific order. Please respect same order !

The complete installation take around ~60 min depending power of the computer and your knowledges to understand what I am doing.

---
<br />

## Install dependencies
```sh
sudo apt install git zsh zsh-syntax-highlighting curl i3 rofi compton \
tree ripgrep fd-find silversearcher-ag unzip bat \
neofetch stow mlocate zoxide python3-pip libsqlite3-dev \
libssl-dev
```
<br /><br />

## OH-MY-ZSH - install
https://ohmyz.sh/#install
```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
Close terminal.<br />
Logout then login.<br />
Open terminal.
<br /><br /><br />

## Create folder structure
```sh
cd ~ && mkdir ~/Flo ~/Flo/Dev ~/Flo/Downloads ~/Flo/Apps ~/Flo/Dotfiles
```
<br /><br />

## NEOVIM - install from sources
https://github.com/neovim/neovim/wiki/Building-Neovim

1. Install dependencies
```sh
sudo apt install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config doxygen
```
<br />

2. Clone Neovim repository
```sh
cd ~/Flo/Apps && git clone https://github.com/neovim/neovim Neovim
```
<br />

3. Compile sources
```sh
cd Neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
```
```sh
sudo make install
```
<br /><br />

## PACKER - install
https://github.com/wbthomason/packer.nvim
```sh
cd ~ && git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
<br /><br />

## PYNVIM - install
https://github.com/neovim/pynvim<br />
We need it for some Neovim's plugins.
```sh
cd ~ && pip3 install pynvim
```
<br /><br />

## NEOVIM - basic config
*Nota Bene: Advanced config later.*

Change ```{your-name}``` by your name. In my case ```FloSlv```.<br /><br />

1. Create folders and files
```sh
cd ~/.config && mkdir nvim nvim/lua nvim/plugin nvim/lua/{your-name} nvim/lua/{your-name}/undodir nvim/lua/{your-name}/globals
```
```sh
cd nvim && touch init.lua
```
```sh
cd lua/{your-name} && touch packer.lua
```
```sh
cd globals && touch options.lua keymaps.lua utils.lua autosave.lua autorun.lua
```
<br />

2. Add basic config<br />

Open `options.lua`<br />
Copy/paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/neovim/lua/FloSlv/globals/options.lua

```sh
nvim options.lua
```
<br />

Open `keymaps.lua`<br />
Copy/paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/neovim/lua/FloSlv/globals/keymaps.lua

```sh
nvim keymaps.lua
```
<br />

Open `utils.lua`<br />
Copy/paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/neovim/lua/FloSlv/globals/utils.lua

```sh
nvim utils.lua
```
<br />

Open `autosave.lua`<br />
Copy/paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/neovim/lua/FloSlv/globals/autosave.lua

```sh
nvim autosave.lua
```
<br />

Open `autorun.lua`<br />
Copy/paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/neovim/lua/FloSlv/globals/autorun.lua

```sh
nvim autorun.lua
```
<br />

Open `packer.lua`<br />
Copy/paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/neovim/lua/FloSlv/packer.lua

```sh
cd .. && nvim packer.lua
```
<br />

Open `init.lua`<br />
Copy/paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/neovim/init.lua

```sh
cd ../.. && nvim init.lua
```
<br />

Go back open `packer.lua`<br />
You will have an error about some modules not found. It's normal. Just push Enter.<br />
Launch vim command: PackerSync
```sh
cd lua/{your-name} && nvim packer.lua
```
If some modules are not Sync correctly, save/close, re open and re do :PackerSync
<br /><br />

Change Neovim colorscheme.<br />
Go to plugin folder.<br />
Create `colorscheme.lua`<br />
Copy/paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/neovim/plugin/colorscheme.lua

```sh
cd ../../plugin && nvim colorscheme.lua
```
<br /><br />

## TMUX - install from sources
1. Remove existing Tmux package
```sh
cd ~ && sudo apt update && sudo apt upgrade
```
```sh
sudo apt remove tmux && sudo apt autoremove
```
```sh
rm -rf .tmux
```
<br />

2. Install prerequisite libraries
```sh
sudo apt install libevent-dev ncurses-dev build-essential bison
```
<br />

3. Fetch Tmux from Git repo
```sh
cd ~/Flo/Apps && git clone https://github.com/tmux/tmux.git Tmux
```
<br />

4. Compile sources
```sh
cd Tmux && sh autogen.sh
```
```sh
./configure
```
```sh
make && sudo make install
```
<br />

5. Check version of Tmux
```sh
tmux -V
```
<br /><br />

## TMUX - config
1. Create .tmux and tmux-powerline-custom-themes folders
```sh
cd ~ && mkdir .tmux .tmux/tmux-powerline-custom-themes
```
<br />

2. Clone TMUX Plugin Manager and TMUX Powerline
```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
```sh
git clone https://github.com/erikw/tmux-powerline.git ~/.tmux/plugins/tmux-powerline
```
<br />

3. Fetch `.tmux.conf` and `.tmux-powerlinerc` files from my GitHub repo

https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/tmux/.tmux.conf
```sh
wget https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/tmux/.tmux.conf
```

https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/tmux/.tmux.powerlinerc
```sh
wget https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/tmux/.tmux.powerlinerc
```

https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/tmux/.tmux/tmux-powerline-custom-themes/flo-theme.sh
```sh
wget -P ~/.tmux/tmux-powerline-custom-themes https://raw.githubusercontent.com/Flo-Slv/Dotfiles/main/tmux/.tmux/tmux-powerline-custom-themes/flo-theme.sh
```
<br />

4. Open `.tmux.conf`, install plugins and reload TMUX.
```sh
tmux
```
```sh
cd ~ && nvim .tmux.conf
```
```sh
# ctrl+z I to install plugins
# ctrl+z r to re source tmux
# Save/close
```
<br />

5. Add my custom `flo-theme.sh` as `default.sh` theme for tmux-powerline 
```sh
mv ~/.tmux/plugins/tmux-powerline/themes/default.sh ~/.tmux/plugins/tmux-powerline/themes/default.sh.old
```
```sh
ln -s ~/.tmux/tmux-powerline-custom-themes/flo-theme.sh ~/.tmux/plugins/tmux-powerline/themes/default.sh
```
<br />

Close Tmux then close and re open terminal.
<br /><br /><br />

## BTOP - install
https://github.com/aristocratos/btop#installation

Download latest release (x86_64 linux version in my case) into `~/Flo/Downloads`<br />
https://github.com/aristocratos/btop/releases
```sh
cd ~/Flo/Apps && mkdir Btop && mv ~/Flo/Downloads/btop-x86_64-linux-musl.tbz ~/Flo/Apps/Btop
```
```sh
cd ~/Flo/Apps/Btop && tar -xjf btop-x86_64-linux-musl.tbz && rm btop-x86_64-linux-musl.tbz
```
```sh
sudo make install
```
<br /><br />

## ZSH - config
Create `ys-flo.zsh-theme`<br />
Copy-paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/oh-my-zsh/ys-flo.zsh-theme
```sh
cd ~/.oh-my-zsh/custom/themes && nvim ys-flo.zsh-theme
```
<br />

Install plugin `zsh-autosuggestions`<br />
https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
<br />

Install plugin `zsh-syntax-highlighting`<br />
https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```
<br />

Open `.zshrc`<br />
Copy/paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/zsh/.zshrc
```sh
cd ~ && rm .zshrc && nvim .zshrc
```
Close terminal and re open it.<br />

PS: do not copy/paste if you don't understand. You need to adapt with your own aliases, tmux panes sizes etc...
<br /><br /><br />

## fzf - install
https://github.com/junegunn/fzf
```sh
cd ~/ && git clone https://github.com/junegunn/fzf .fzf
```
```sh
cd .fzf && ./install
```
<br />

Close terminal and re open it.
<br /><br /><br />

## NVM - install
https://github.com/nvm-sh/nvm#installing-and-updating
```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

Close terminal and re open it.

```sh
nvm install 18
```
```sh
nvm install 16
```
```sh
nvm use 16
```
<br /><br />

## GIT - config
1. Create `.gitconfig`<br />
```sh
cd ~ && touch .gitconfig
```
<br />

2. Add content to `.gitconfig`<br />

Just copy/paste those lines into your terminal but change before your email and name !
```sh
cat << EOF >> .gitconfig
[user]
    email = {your-email}
    name = {your-name}
[core]
    editor = nvim
EOF
```
<br /><br />

## GIT-CZ - install and config
https://github.com/streamich/git-cz
```sh
cd ~ && npm install -g git-cz
```
<br />

Create `changelog.config.js`<br />
Copy/paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/git/changelog.config.js
```sh
cd ~ && nvim changelog.config.js
```
<br /><br />

## GITUI - install and config
1. Install Rust (and Cargo)

https://www.rust-lang.org/tools/install
```sh
cd ~ && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
<br />
Close and re open terminal.<br />
<br />

2. Install GitUI

https://github.com/extrawurst/gitui#build
```sh
cargo install gitui
```
<br />

3. Configure GitUI
```sh
cd ~/.config && mkdir gitui && cd gitui && touch theme.ron key_bindings.ron
```
<br />

Open `theme.ron`<br />
Copy/paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/gitui/theme.ron
```sh
nvim theme.ron
```
<br />

Open `key_bindings.ron`<br />
Copy/paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/gitui/key_bindings.ron
```sh
nvim key_bindings.ron
```
<br /><br />

## KITTY - install
https://sw.kovidgoyal.net/kitty/binary/
```sh
cd ~ && curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```
<br />

Create `kitty.conf`<br />
Copy/paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/kitty/kitty.conf
```sh
cd ~/.config/kitty && nvim kitty.conf
```
<br />

Desktop icons etc...
```sh
cd ~/.local && mkdir bin && ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
```
```sh
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
```
```sh
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
```
```sh
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
```
```sh
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
```
<br />

Close terminal and open Kitty terminal.
<br /><br /><br />

## HACK FONT - install
Go to https://www.nerdfonts.com/font-downloads<br />
Download Hack Nerd Font into `~/Flo/Downloads`.
```sh
cd ~/.local/share && mkdir fonts && cd fonts && mv ~/Flo/Downloads/Hack.zip .
```
```sh
unzip Hack.zip && rm -rf Hack.zip
```
<br />

Close and re open Kitty terminal.
<br /><br />

Check if Hack Nerd Font have been installed correctly.
```sh
kitty +list-fonts
```
<br />

Optional: to have Hack Nerd Font available in Polybar.
```sh
sudo mkdir /usr/share/fonts/truetype/hack-nerd-font && \
sudo cp ~/.local/share/fonts/Hack\ Nerd\ Font\ Complete.ttf /usr/share/fonts/truetype/hack-nerd-font/
```
<br /><br />

## NOTION - install
https://notion-enhancer.github.io/getting-started/installation/
```sh
echo "deb [trusted=yes] https://apt.fury.io/notion-repackaged/ /" | sudo tee /etc/apt/sources.list.d/notion-repackaged.list
```
```sh
sudo apt update && sudo apt install notion-app-enhanced
```
<br /><br />

## INSOMNIA - install
https://docs.insomnia.rest/insomnia/install
```sh
echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" | sudo tee -a /etc/apt/sources.list.d/insomnia.list
```
```sh
sudo apt update && sudo apt install insomnia
```
<br />

You can install plugins in Insomnia: tokyonight theme, gist integration and os infos.
<br /><br /><br />

## DISCORD - install
https://discord.com/<br />
Download tar.gz archive into `~/Flo/Downloads`.
```sh
cd ~/Flo/Downloads && sudo tar -xvzf discord-0.0.18.tar.gz -C /opt
```
```sh
cd ~ && sudo ln -sf /opt/Discord/Discord /usr/bin/Discord
```
```sh
cd ~ && sudo cp -r /opt/Discord/discord.desktop /usr/share/applications
```
```sh
cd /usr/share/applications && sudo nvim discord.desktop
```
```sh
Exec=/usr/bin/Discord
Icon=/opt/Discord/discord.png
```
<br /><br /><br />

## BETTER DISCORD - install
https://github.com/BetterDiscord/BetterDiscord<br />
Download Linux AppImage into `~/Flo/Downloads`
```sh
cd ~/Flo/Downloads && chmod +x BetterDiscord-Linux.AppImage
```
<br />

Install FUSE dependencies<br />
https://github.com/AppImage/AppImageKit/wiki/FUSE
```sh
sudo add-apt-repository universe
```
```sh
sudo apt install libfuse2
```
<br />

Install BetterDiscord on classic Ubuntu version
```sh
./BetterDiscord-Linux.AppImage
```
<br />

Install BetterDiscord on Ubuntu VM version
```sh
./BetterDiscord-Linux.AppImage --disable-gpu-sandbox
```
<br /><br />

## GLOW - install
https://github.com/charmbracelet/glow
```sh
echo 'deb [trusted=yes] https://repo.charm.sh/apt/ /' | sudo tee /etc/apt/sources.list.d/charm.list
```
```sh
sudo apt update && sudo apt install glow
```
<br /><br />

## I3WM - config
1. ROFI - config
```sh
cd ~/.config && mkdir rofi
```
```sh
cd rofi && touch config.rasi flo-theme.rasi
```
<br />

Open `config.rasi`<br />
Copy/paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/rofi/config.rasi
```sh
nvim config.rasi
```
<br />

Open `flo-theme.rasi`<br />
Copy/paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/rofi/flo-theme.rasi
```sh
nvim flo-theme.rasi
```
<br /><br />

2. POLYBAR - install and config

https://github.com/polybar/polybar/wiki/Compiling<br />
Install Polybar from sources and dependencies
```sh
cd ~/ && sudo apt install build-essential git cmake cmake-data pkg-config python3-sphinx python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev
```
<br />

Download last release: https://github.com/polybar/polybar/releases
```sh
cd ~/Flo/Downloads && tar xvzf polybar-<version>.tar
```
```sh
mv polybar-<version> ~/Flo/Apps/Polybar-<version> && cd ~/Flo/Apps/Polybar-<version> && mkdir build && cd build
```
```sh
cmake ..
```
```sh
make -j$(nproc)
```
```sh
sudo make install
```
<br />

Create all necessaries folder and files.
```sh
cd ~/.config && mkdir polybar && cd polybar && touch polybar.sh config.ini && chmod +x polybar.sh
```
<br />

Open `polybar.sh`<br />
Copy/paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/polybar/polybar.sh
```sh
nvim polybar.sh
```
<br />

Open `config.ini`<br />
Copy/paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/polybar/config.ini
```sh
nvim config.ini
```
<br /><br />

3. I3-WM - config
```sh
cd ~/.config && mkdir i3 && cd i3 && touch config
```
<br />

Open `config`<br />
Copy/paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/i3/config
```sh
nvim config
```
<br />

Close Kitty.<br />
Close all others windows.<br />
Logout.<br />
Choose i3 as windows manager.<br />
Login.
<br /><br /><br />

## SSH - github keys
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
```sh
cd ~/.ssh && ssh-keygen -t ed25519 -C "your_email@example.com"
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
cat id_ed25519.pub
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

<br /><br />

## NEOVIM - advanced config
Install Tree-Sitter
```sh
npm i -g tree-sitter-cli
```
```sh
# TO DO !
```
<br /><br />

## STOW
https://linux.die.net/man/8/stow<br />
At this point, I would like to have an unique Dotfiles directory.<br />
Do not reproduce if you don't understand !
<br />

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
<br /><br />

Configuration of my Dotfiles folder.
```sh
cd ~/Flo/Dotfiles && mkdir i3 && mv ~/.config/i3/config ~/Flo/Dotfiles/i3 && stow -t ~/.config/i3 i3
```
```sh
cd ~/Flo/Dotfiles && mkdir kitty && mv ~/.config/kitty/kitty.conf ~/Flo/Dotfiles/kitty && stow -t ~/.config/kitty kitty
```
```sh
cd ~/Flo/Dotfiles && mkdir polybar && mv ~/.config/polybar/config.ini ~/Flo/Dotfiles/polybar &&\
mv ~/.config/polybar/polybar.sh ~/Flo/Dotfiles/polybar && stow -t ~/.config/polybar polybar
```
```sh
cd ~/Flo/Dotfiles && mkdir rofi && mv ~/.config/rofi/config.rasi ~/Flo/Dotfiles/rofi &&\
mv ~/.config/rofi/flo-theme.rasi ~/Flo/Dotfiles/rofi && stow -t ~/.config/rofi rofi
```
```sh
cd ~/Flo/Dotfiles && mkdir gitui && mv ~/.config/gitui/theme.ron ~/Flo/Dotfiles/gitui &&\
mv ~/.config/gitui/key_bindings.ron ~/Flo/Dotfiles/gitui && stow -t ~/.config/gitui gitui
```
```sh
cd ~/Flo/Dotfiles && mkdir neovim && mv ~/.config/nvim/* ~/Flo/Dotfiles/neovim && stow -t ~/.config/nvim neovim
```
```sh
cd ~/Flo/Dotfiles && mkdir oh-my-zsh && mv ~/.oh-my-zsh oh-my-zsh && stow -t ~/ oh-my-zsh
```
```sh
cd ~/Flo/Dotfiles && mkdir tmux && mv ~/.tmux tmux && mv ~/.tmux.conf tmux && mv ~/.tmux.powerlinerc tmux &&\
stow -t ~/ tmux
```
```sh
cd ~/Flo/Dotfiles && mkdir zsh && mv ~/.zshrc zsh && mv ~/.zshenv zsh && stow -t ~/ zsh
```
```sh
cd ~/Flo/Dotfiles && mkdir git && mv ~/.changelog.config.js ~/.gitconfig git && stow -t ~/ git
```
<br /><br />

## Starship - install
https://github.com/starship/starship
```sh
cd ~/ && curl -sS https://starship.rs/install.sh | sh
```
```sh
echo 'eval "$(starship init zsh)"' >> .zshrc
```
<br />

Create `starship.toml`<br />
*Nota Bene: there are 2 files, one for classic Ubuntu, one for Ubuntu VM version.*

Copy-paste this file: https://github.com/Flo-Slv/Dotfiles/blob/main/starship/starship.toml
```sh
cd ~/.config && nvim starship.toml
```
```sh
cd ~/Flo/Dotfiles && mkdir starship && mv ~/config/starship.toml starship && stow -t ~/.config starship
```
<br /><br />

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
