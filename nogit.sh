#!/bin/bash

check_dirs=".config Dev Documents"
cd ~

if [ ! -f ~/Dev/sh/nogit/tmp.txt ]; then
  touch ~/Dev/sh/nogit/tmp.txt
fi

for dir in $check_dirs; do
  if [[ $dir == "Dev" ]]; then
    fd . $dir --full-path --maxdepth 2 --type d &>> ~/Dev/sh/nogit/tmp.txt
  else
    fd . $dir --full-path --maxdepth 1 --type d &>> ~/Dev/sh/nogit/tmp.txt
  fi
done

all_proj=$(<~/Dev/sh/nogit/tmp.txt)


for proj in $all_proj; do
  if [ ! -d ~/$proj/.git ]; then
    if fd --maxdepth 1 --full-path --type f . ~/$proj | grep "/" &> /dev/null; then
      if ! cat ~/Dev/sh/nogit/ignore | grep $dir; then
        echo $proj
      fi
    fi
  fi
done

rm -f ~/Dev/sh/nogit/tmp.txt
cd $prev
