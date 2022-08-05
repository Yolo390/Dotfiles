############
## .zshrc ##
############

# by Flo Slv

# ~/.zshrc


# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="ys-flo"

plugins=(
	git
	command-not-found
	zsh-autosuggestions
	zsh-syntax-highlighting
	rust
)

source $ZSH/oh-my-zsh.sh


# Add ctrl+space to autocomplete in prompt.
bindkey '^ ' autosuggest-accept


# Remove all unnecessary aliases created by oh-my-zsh
unalias ${(k)aliases}
unalias "..."
unalias "...."
unalias "....."
unalias "......"


alias c="clear"


# Change directory aliases
alias d="cd ~/Flo"
alias dev="cd ~/Flo/Dev"
alias dot="cd ~/Flo/Dotfiles"


# List aliases
alias la="ls -lAh"
alias ls="ls --color=tty"


# TMUX aliases
alias tm="tmux -f ~/Flo/Dotfiles/tmux/.tmux.conf new -s"
alias tma="tmux attach-session" # The last session.
alias tman="tmux attach-session -t"
alias tmls="tmux ls"
alias tmk="tmux kill-session -t"


# Git aliases
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gpo='git pull origin'


# Rust aliases
alias cdoc="cargo doc --open"


# fzf aliases
alias ff="fzf"
alias ffc"=fzf --preview 'batcat --style=numbers --color=always --line-range :500 {}'"
alias ft="fzf-tmux"
alias ftt="fzf-tmux -p"


# BATCAT alias
alias b='batcat'


# Add Github key to SSH agent.
alias sa="eval `ssh-agent`"
alias ss="ssh-add ~/.ssh/id_ed25519"


# MongoDB aliases
alias ms="sudo systemctl start mongod"
alias mi="sudo systemctl status mongod"
alias md="sudo systemctl stop mongod"
alias mr="sudo systemctl restart mongod"


# Find the name of WM_CLASS to set in i3 config file.
alias xg="xprop | grep WM_CLASS"


# If UBUNTU SOFTWARE does not load anymore.
alias ubuntu-software="killall snap-store"


# Launch Gnome Control Center
alias settings="env XDG_CURRENT_DESKTOP=GNOME gnome-control-center"


# Launch gitui app.
alias ui="gitui"


# Colored man
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'


# Set VIM as default editor
export VISUAL=nvim
export EDITOR="$VISUAL"

alias n="nvim"
alias vim="nvim"


# Add directory to the PATH
export PATH="/home/flo/.local/bin:$PATH"


# fzf configuration.
export FZF_DEFAULT_OPTS='--height 40%'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Every time I open a new terminal.
tmux has-session -t Flo || \
	tmux -f ~/.tmux.conf new -s Flo -n Terminal \; \
	split-window -c ~/ -h \; \
	split-window -c ~/ -v \; \
	select-pane -t 3 \; \
	resize-pane -t 3 -y 20 \; \
	new-window -c ~/ -n Neovim \; \
	new-window -c ~/ -n Btop btop \; \
	select-window -t 1 \; \
	select-pane -t 1 \; \
	resize-pane -t 1 -x 85 \; \
	send-keys 'xset r rate 220 50' Enter \; \
	send-keys 'clear' Enter \; \


# Zoxide
eval "$(zoxide init zsh)"


#eval "$(starship init zsh)"
