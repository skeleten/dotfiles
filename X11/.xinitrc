#!/bin/bash
# -*- mode: shell-script -*-

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Set up xrandr
case $(hostname) in
    "styx")
	xrandr --output HDMI-A-0 --primary --auto \
	       --output DisplayPort-2 --right-of HDMI-A-0 --auto
    ;;
esac

setxkbmap de
xrdb "$HOME/.Xresources"
if [ -z "$WM" ]; then
    WM=i3
fi
exec $WM 2>/tmp/xinit_stderr >/tmp/xinit_stdout
