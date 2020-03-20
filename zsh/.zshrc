###############################################################################
# OH MY ZSH
################################################################################

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="fishy"

plugins=(
    archlinux
    common-aliases
    dotenv
    git
    systemd
    vagrant
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# setting shell options
#
# see zshoptions(1) for more details on the individual options

setopt -o nomatch

PATH+=":$HOME/.bin"
PATH+=":$HOME/.cargo/bin"
export EDITOR=emacsclient

export GNOME_KEYRING_CONTROL="$XDG_RUNTIME_DIR/keyring"

################################################################################
# Custom aliases
################################################################################

# git

alias gd="git difftool --no-symlinks --dir-diff"

# general / misc

alias e="emacsclient"
alias S="sudo"

# pacman

alias pminst="trizen -Syu --noconfirm"
alias pmsrch="trizen -Ss"

# systemd
alias scu="systemctl --user"

alias ls="exa"
alias ll="exa -lF"

alias screeny="/usr/bin/gsu"

alias kdiff="kitty +kitten diff"
alias icat="kitty +kitten icat"
alias kssh="kitty +kitten ssh"

################################################################################
# Functions
################################################################################

function mkcd() {
    mkdir -p $1 && cd $1
}

################################################################################
# Bugfixes and workarounds
################################################################################

export _JAVA_AWT_WM_NONREPARENTING=1

################################################################################
# GPG and SSH Key agent
################################################################################

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
