#!/bin/bash

# seek help: man info apropos whatis tldr

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

################ ---------------------
### aliases
################ ---------------------

alias o=xdg-open
alias ls=exa
alias l='exa -la --icons --sort=type'
alias ll='exa -l --icons --sort=type'
alias r="ranger"
alias ydl360='youtube-dl -c -f 247+251'
alias ydl480='youtube-dl -c -f 248+251'
alias ydl720='youtube-dl -c -f 271+251'
alias pasteimage="xclip -sel clip -t image/png -o" 
alias copyimage="xclip -sel clip -t image/png" 
alias imgprimtoclip="xclip -sel p -t image/png -o | xclip -sel clip -t image/png"

alias myp="cd ~/myp/"
alias myc="cd ~/myconfig"
alias edu="cd ~/edu/edu1"

alias yws="yarn workspace"
alias ywsf="yarn workspaces foreach"
alias ywsi="yarn workspaces foreach --include"

################ ---------------------
### default apps
################ ---------------------

export EDITOR=nvim

################ ---------------------
### my own scripts
################ ---------------------

# tmux has to be working
tmux-ide() {
  tmux split-window -v -p 30
  tmux split-window -h -p 66 
  tmux split-window -h -p 50
}

mem(){ free | awk '/^Mem/ { print $3/$2"%" }' }
memusage(){ ps -axch -o cmd,%mem --sort=-%mem | head -n $(test $1 && echo $1 || echo 10) }

# npt() {
#   prayers=$(ipraytime -lat 30 -lon 31 -b)
#   current_time=$(expr $(date +%H) \* 60 + $(date +%M))
#   i=2
#   for (( ; i<8; i++)); do 
#     paryer_name=$(echo $prayers | sed "1!d" | awk "{ print \$$i }")
#     paryer_time=$(echo $prayers | sed "3!d" | awk "{ print \$$i }")
#     hours=$(echo $prayer_time | sed -r "s/:[0-9]+//")
#     mins=$(echo $prayer_time | sed -r "s/[0-9]+://")
#     echo $hours $mins
#     prayer_t=$(expr $hours \* 50 + $mins)
#     echo test $prayer_t -gt $current_time && break
#   done
#   echo $prayer_name  $prayer_time
# }

# list all + exclude
function lae() {
  if [ "$#" -lt 2 ]; then
    echo invalid number of arguments >&2
    return 2
  fi
  local dir=$1; shift
  local patterns="\\($1\\)"; shift
  while [ "$#" -gt 0 ]; do
    patterns+="\\|\\($1\\)"; shift
  done
  # list the first arg, and exclude the reset
  /bin/ls -A "$dir" | sed "/^$patterns$/ d"
}

# -----------------------------------------
#        C/C++: watch and run
# -----------------------------------------

function wmake() {
  local files=$(ls *.c)
  (($?)) && return 0
  if [ -z "$files" ]; then echo "no file found to make!"; return 1; fi
  (($#)) && exec="&& echo ------- starting ------- && ./$1 && echo ------- ending -------" && shift
  nodemon -w "${files[@]}" -e c,cc,cpp -x "make $exec"
}

function wgc() {
  # validation
  local err=;local file=
  if [ ! $1 ]; then err="you have to pass the filename!";
  elif [ ! -f "$1.c" ]; then err="file not found: ./$1.c"; fi
  if [ $err ]; then echo $err >&2; return 1; fi
  # command to watch and compile
  file=$1; shift
  nodemon -w $file.c -e c -x \
    "gcc $file.c -o $file $@ && ./$file"
}

function rgc() {
  # validation
  local err=;local file=
  if [ ! $1 ]; then err="you have to pass the filename!";
  elif [ ! -f "$1.c" ]; then err="file not found: ./$1.c"; fi
  if [ $err ]; then echo $err >&2; return 1; fi
  # command to watch and compile
  file=$1; shift
  gcc $file.c -o $file $@ && ./$file
}

function wgcc() {
  # validation
  local err=;local file=
  if [ ! $1 ]; then err="you have to pass the filename!";
  elif [ ! -f "$1.cc" ] && [ ! -f "$1.cpp" ]; then err="file not found: './$1.cc' and './$1.cpp'" fi
  if [ $err ]; then echo $err >&2; return 1; fi
  # command to watch and compile

  file=$1; shift
  [ -f "$file.cc" ] && \
    nodemon -w $file.cc -e cc -x "g++ $file.cc -o $file $@ && ./$file" || \
    nodemon -w $file.cpp -e cpp -x "g++ $file.cpp -o $file $@ && ./$file"
}

function rgcc() {
  # validation
  local err=;local file=
  if [ ! $1 ]; then err="you have to pass the filename!";
  elif [ ! -f "$1.cc" ] && [ ! -f "$1.cpp" ]; then err="file not found: './$1.cc' and './$1.cpp'" fi
  if [ $err ]; then echo $err >&2; return 1; fi
  # command to watch and compile
  
  file=$1; shift
  [ -f "$file.cc" ] && \
    g++ $file.cc -o $file $@ && ./$file || \
    g++ $file.cpp -o $file $@ && ./$file
}

