Simple bash scripts to transfer file over SSH session's stdin/stdout.
Based on the idea of [iterm2-zmodem](https://github.com/mmastrac/iterm2-zmodem). This is just an experiment for now.

Licensed under cc-wiki with attribution required. All the scripts are in public domain.

# How it works

Suppose you already have a SSH session in a terminal emulator, one simple way to send file to the remote machine is execute `cat > file` and then paste the file content to the terminal. This works because the stdin of the command is redirected to a file.

The scripts rely on iTerm2's [coprocess](http://www.iterm2.com/coprocesses.html) feature, which allows you to connect the sessions stdin/stdout to another job's stdout/stdin.

# Integrate with iTerm2

Please refer to iterm2-zmodem's README. A few differences:

1. Replace the matching regular expression
2. Run `brz.sh` on remote machine to receive file on it

# File transfer protocol

SSH should provide reliable data transfer, so there's no error checking in the protocol.

1. First line represents file name
2. Next comes file content encoded in base64
3. Empty line signals the end of one file
4. Empty line without current file name signals end of transfer

Repeat the first three steps to transfer multiple files.

# Problems

- Not reliable for large file transfer
