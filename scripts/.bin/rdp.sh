#!/usr/bin/env bash

cat=$(rdp-menu | rofi -dmenu -p "RDP: ")
clt=$(rdp-menu -c "$cat" | rofi -dmenu -p "RDP ($cat):")
rdp-menu -c "$cat" -n "$clt"
