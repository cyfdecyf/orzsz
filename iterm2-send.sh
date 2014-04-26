#!/bin/bash

FILE=`osascript -e 'tell application "iTerm" to activate' -e 'tell application "iTerm" to set thefile to choose file with prompt "Choose a file to send"' -e "do shell script (\"echo \"&(quoted form of POSIX path of thefile as Unicode text)&\"\")"`

if [[ $FILE = "" ]]; then
    echo # Signal end of transfer.
    exit 0
fi

function send1() {
    local file
    file=$1

    echo `basename $file`
    base64 -b 76 $file
    echo
}

send1 $FILE

# Signal end of transfer.
echo

