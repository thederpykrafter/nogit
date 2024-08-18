#!/bin/bash
prev=$PWD

function nogit() {
  cd ~
  for x in $(fd . $1 --full-path --maxdepth $2 --type d); do
    cd ~/$x
      if ! cat ~/Dev/sh/nogit/ignore | grep $x &> /dev/null; then
        [[ ! -d .git ]] && \
        [[ $(fd --maxdepth 1 --type f) != "" ]] && echo $x # check for files
      fi
  done
}

nogit Dev 2
nogit .config 1
[[ -d ~/Documents ]] && nogit Documents 1

cd $prev
