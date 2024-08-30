#!/bin/bash
prev=$PWD

# NOTE: ignores dirs with no files
function nogit() {
  cd ~
  for x in $(fd . $1 --full-path --maxdepth $2 --type d); do
    cd ~/$x
      if ! cat ~/Dev/sh/nogit/ignore | grep $x &> /dev/null; then
        [[ ! -d .git ]] && \
        [[ $(fd --maxdepth 1 --type f) != "" ]] && \
        echo $x # check for files
      fi
  done
}

# Usage:
# nogit [dir] [depth]
nogit Dev 2
nogit Dev/assets 2
nogit .config 1
# check if ~/Documents exists for termux compatibility
[[ -d ~/Documents ]] && nogit Documents 1

cd $prev
