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
  # only print this if not being piped or redirected
  [[ -t 1 && ! -p /dev/stdout ]] && \
    echo -e "\x1b[94m"$1"\x1b[m" >&2

  IFS=$'\n'; for dir in $(fd . $1 --full-path --maxdepth $2 --type d); do
    cd ~/$dir
    # ignore paths in $BASH_SOURCE/ignore
    if ! cat ~/Dev/sh/nogit/ignore | grep $dir &> /dev/null; then
      # check for files
      [[ ! -d .git ]] && [[ $(fd --maxdepth 1 --type f) != "" ]] && \
        echo "~/$dir"
    fi
  done
}

function main_nogit() {
  # Usage:
  # nogit [dir] [depth]
  nogit Dev 2
  nogit .config 1
  # check if dirs exists for termux compatibility
  [[ -d ~/Assets ]] && nogit Assets 2
  [[ -d ~/Documents ]] && nogit Documents 1
}

#TODO: dont overite entire ignore everytime
function should_ignore() {
  read -n1 -sp "Select paths to ignore? [y/N]" answer
  if [[ $answer == "y" ]] || [[ $answer = "Y" ]]; then
    SRC_DIR=`dirname "$0"`
    [[ $SRC_DIR == "." ]] && SRC_DIR=$(pwd)
    main_nogit | fzf | tee $SRC_DIR/ignore > /dev/null
    sort -o $SRC_DIR/ignore $SRC_DIR/ignore
  fi
  echo
}

main_nogit
[[ -t 1 && ! -p /dev/stdout ]] && [[ `main_nogit` != "" ]] && should_ignore
cd $prev
