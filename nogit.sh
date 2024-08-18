#!/bin/bash
prev=$PWD

function findDirs() {
  cd ~
  fd . $1 --full-path --maxdepth $2 --type d
}


function nogit() {
  for x in $(findDirs $1 $2); do
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
