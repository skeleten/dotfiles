#!/usr/bin/bash
echo "\$1 = $1"
echo "\$2 = $2"
su -c "\"export DISPLAY=$1; /home/skeleten/.bin/lock.sh\"" - $2
