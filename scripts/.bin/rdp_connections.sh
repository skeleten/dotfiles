#!/usr/bin/env bash

PROFILE_FILE=${PROFILE_FILE:-"$HOME/.config/rdp-profiles"}

EXTRA_OPTIONS=${EXTRA_OPTIONS:-"/dynamic-resolution"}
PASS_FOLDER=${PASS_FOLDER:-"RDP"}


function get_options_from_line() {
	host=$(echo $1 | cut -d';' -f1)
	user=$(echo $1 | cut -d';' -f2)
	domain=$(echo $1 | cut -d';' -f3)    
}

function get_options_for_name() {
    while IFS='' read -r line || [[  -n $line ]]; do
	get_options_from_line "$line"
	if [[ "$1" == "$host" ]]; then	    
	    connect	
	fi
    done < $PROFILE_FILE
}

function connect() {
    nohup xfreerdp /v:$host /u:$user /d:$domain /p:"$(pass $PASS_FOLDER/$host)" $EXTRA_OPTIONS &>/dev/null &
    exit
}

function print_options() {
    while IFS='' read -r line || [[ -n $line ]]; do
        get_options_from_line "$line"
	if [[ ! -z $host ]]; then
	    echo $host
	fi
    done < $PROFILE_FILE
}

if [[ -z "$@" ]]; then
    print_options
else
    get_options_for_name $1
fi
