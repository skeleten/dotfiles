export ZSH="/home/skeleten/.oh-my-zsh"

ZSH_THEME="theunraveler"

plugins=(
    archlinux
    common-aliases
    dotenv
    git
    systemd
    vagrant
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# setting shell options
#
# see zshoptions(1) for more details on the individual options

setopt -o nomatch

PATH+=":$HOME/.bin"
export EDITOR=emacsclient

################################################################################
# Custom aliases
################################################################################

# general / misc

alias e="emacsclient"

# pacman

alias pminst="trizen -S --noconfirm"
alias pmsrch="trizen -Ss"

# systemd
alias scu="systemctl --user"

alias ls="exa"
alias ll="exa -lF"

################################################################################
# Functions
################################################################################

function mkcd() {
    mkdir -p $1 && cd $1
}
