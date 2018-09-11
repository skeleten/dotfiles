#!/bin/bash
#
# ~/.bashrc
#
# -*- mode: shell-script -*-

SESSION_FILE="/tmp/.Xsession"

source ~/.bashenv

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# no job control
# [[ $- != *m* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

case $TERM in
    *xterm* | *rxvt* | *screen* | *eterm*)
	# on any terminal like tty, we're gonna run a fish shell
        exec /usr/bin/zsh
        ;;
    linux)
	# when we're in our login shell, and drop inzshrto an Xsession if
	# none is existent.  otherwise, drop into a fish shell
        if [[ -f "$SESSION_FILE" ]]; then
            exec /usr/bin/zsh
        else
            touch "$SESSION_FILE"
            /usr/bin/startx
	    rm "$SESSION_FILE"
            exit
        fi
        ;;
esac
