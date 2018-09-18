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

PATH+=":$HOME/.bin"

alias e="emacsclient"
export EDITOR=emacsclient

alias pminst="trizen -S --noconfirm"
alias pmsrch="trizen -Ss"
