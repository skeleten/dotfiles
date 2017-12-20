#!/usr/bin/bash
# -*- mode: shell-script -*-

LOGFILE=$HOME/.log/polybar.log

DISPLAYS=$(polybar -m | sed 's/:.*//g')

echo "Killing all old instances" >> $LOGFILE
killall polybar
# Start polybar for each display
for m in $DISPLAYS; do
    export pb_disp=$m
    echo "Starting polybar for $m" >> $LOGFILE
    polybar top 2>&1 >> $LOGFILE &
done
