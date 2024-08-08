#!/bin/bash

check_dirs=".config Dev Documents"
cd ~

if [ ! -f ~/Dev/sh/nogit/tmp.txt ]; then
  touch ~/Dev/sh/nogit/tmp.txt
fi

for dir in $check_dirs; do
  if [ -d $dir ]; then
    fd . $dir --full-path --maxdepth 2 --type d &>> ~/Dev/sh/nogit/tmp.txt
  fi
done

all_proj=$(<~/Dev/sh/nogit/tmp.txt)

rm -f ~/Dev/sh/nogit/tmp.txt

for proj in $all_proj; do
  if [ ! -d ~/$proj/.git ]; then
    if fd --maxdepth 1 --full-path --type f . ~/$proj | grep "/" &> /dev/null; then
      echo $proj
    fi
  fi
done

cd $prev
