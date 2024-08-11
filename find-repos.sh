#!/bin/zsh

prev=$PWD
cd ~

function fast_find() {
  for repo in `find ~ -name ".git" -type d | grep -vw ".local" | grep -vw ".cache"`; do
    cd $repo/..
    echo `pwd`: | sed "s/\/home\/thederpykrafter/~/"
  done
}

fast_find

cd $prev
