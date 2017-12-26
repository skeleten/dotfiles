# .bash_profile

if [[ -f ~/.profile ]]; then
    . ~/.profile
fi

if [[ -f ~/.bashenv ]]; then
    . ~/.bashenv
fi

if [[ $- == *i* && -f ~/.bashrc ]]; then
    . ~/.bashrc
fi

export PATH="$HOME/.cargo/bin:$PATH"
