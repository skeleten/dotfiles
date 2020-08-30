#!/bin/bash
# -*- mode: shell-script -*-

eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
dbus-update-activation-environment --systemd DISPLAY

export SSH_AUTH_SOCK

# Set up xrandr
case $(hostname) in
    "erebos")
	xrandr --output HDMI-A-0 --primary --auto \
	       --output DisplayPort-2 --right-of HDMI-A-0 --auto
    ;;
esac

echo "$DISPLAY" > /tmp/XDisplay

setxkbmap us
xrdb "$HOME/.Xresources"
if [ -z "$WM" ]; then
    WM=xmonad
fi
exec $WM 2>/tmp/xinit_stderr >/tmp/xinit_stdout
