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

# GPG Agent stuff

if (pgrep -u "${USER}" gpg-agent); then
    export GPG_AGENT_PID=`pgrep -u ${USER} gpg-agent`
    export GPG_AGENT_INFO=${HOME}/.gnupg/S.gpg-agent:${GPG_AGENT_PID}:1
else
    eval `gpg-agent --enable-ssh-support --daemon`
    export GPG_AGENT_PID=`pgrep -u ${USER} gpg-agent`
    export GPG_AGENT_INFO=${HOME}/.gnupg/S.gpg-agent:${GPG_AGENT_PID}:1
fi
