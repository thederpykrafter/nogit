#!/bin/bash
prev=$PWD

# [[ -t 1 ]] && \
  #   echo "nogit is attached to TTY"
#
# [[ -p /dev/stdout ]] && \
  #   echo "nogit is attached to a pipe" >&2
#
# [[ ! -t 1 && ! -p /dev/stdout ]] && \
  #   echo "nogit is attached to a redirection" >&2

#NOTE: ignores dirs with no files
function nogit() {
  cd ~
  [[ -t 1 && ! -p /dev/stdout ]] && \
    echo -e "\x1b[94m"$1"\x1b[m" >&2

  IFS=$'\n'; for dir in $(fd . $1 --full-path --maxdepth $2 --type d); do
    cd ~/$dir
    if ! cat ~/Dev/sh/nogit/ignore | grep $dir &> /dev/null; then
      [[ ! -d .git ]] && \
        [[ $(fd --maxdepth 1 --type f) != "" ]] && \
        echo "~/$dir" # check for files
    fi
  done
}

# Usage:
# nogit [dir] [depth]
nogit Dev 2
nogit .config 1
# check if ~/Documents exists for termux compatibility
[[ -d ~/Assets ]] && nogit Assets 2
[[ -d ~/Documents ]] && nogit Documents 1

cd $prev
