#!/bin/bash

function clearline() {
	echo -en '\r                                                  \r' > /dev/tty
}

# Magic string to signal running of this script.
# echo "@orz@`echo orz | sha1sum`"
echo -n '@orz@e03afea049e5598d170a20fd0c1e595c52f4c29c' > /dev/tty
sleep 0.2
clearline

function recv1() {
	local filename
	local line

	read filename
	if [[ -z "$filename" ]]; then
		echo 'File receving done' > /dev/tty
		return 1
	fi
	filename=`basename $filename`
	echo "recv $filename" > /dev/tty
	while [[ -n "$filename" ]] ; do
		read line
		if [[ -z "$line" ]]; then # EOF
			break
		else
			echo $line
		fi
	done | base64 --decode > "$filename"

	echo -e "\ndone $filename" > /dev/tty
}

while true ; do
	recv1 || exit $?
done

