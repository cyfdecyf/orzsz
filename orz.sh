#!/bin/bash

function clearline() {
	echo -en '\r                                                  \r' > /dev/tty
}

# Magic string to signal running of this script.
# echo "@orz@`echo orz | sha1sum`"
echo -n '@orz@e03afea049e5598d170a20fd0c1e595c52f4c29c' > /dev/tty
clearline

function recv1() {
	local filename
	local line

	read -s filename
	[[ -z "$filename" ]] && return 1

	filename=`basename $filename`
	echo "recv $filename" > /dev/tty

	while [[ -n "$filename" ]] ; do
		read -s line
		if [[ -z "$line" ]]; then # EOF
			break
		else
			echo "$line"
			echo -n '.' > /dev/tty
		fi
	done | base64 --decode > "$filename"

	echo -e "\ndone $filename" > /dev/tty
}

while true ; do
	recv1 || exit $?
done
