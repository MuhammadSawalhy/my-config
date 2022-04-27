#!/bin/bash

setopt SH_WORD_SPLIT

# seek help: man info apropos whatis tldr

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# ------------------------------------
#              aliases
# ------------------------------------

alias o=xdg-open
alias r="ranger"
alias l='exa -la --icons --sort=type'
alias ll='exa -l --icons --sort=type'
alias ls=exa
alias lg=lazygit
alias alacritty="LIBGL_ALWAYS_SOFTWARE=1 alacritty"
alias prgs='printf "$(git status)"'
alias ydl360='youtube-dl -c -f 247+251'
alias ydl480='youtube-dl -c -f 248+251'
alias ydl720='youtube-dl -c -f 271+251'
alias pasteimage="xclip -sel clip -t image/png -o"
alias copyimage="xclip -sel clip -t image/png"
alias imgptoc="xclip -sel p -t image/png -o | xclip -sel clip -t image/png"
# to paste the image itself in obsidian, I don't want to use the online version
alias imgctoc="xclip -sel clip -t image/png -o | xclip -sel clip -t image/png"

alias myp="cd ~/myp/"
alias myc="cd ~/my-config"
alias edu="cd ~/Documents/edu/2nd-2"

alias yws="yarn workspace"
alias ywsf="yarn workspaces foreach"
alias ywsi="yarn workspaces foreach --include"

# ------------------------------------
#       default common setting
# ------------------------------------

export NEWT_COLORS='
    root=,red
    title=red,white
    textbox=,white
    window=,white
    border=black,white
    button=white,red
    listbox=,white
    actsellistbox=white,red
    compactbutton=,white
    actlistbox=white,red
'

# ------------------------------------
#           default apps
# ------------------------------------

export EDITOR=nvim

# ------------------------------------
#          my own scripts
# ------------------------------------

mem(){ free | awk '/^Mem/ { print $3/$2*100"%" }'; }
memusage(){
  ps -axch -o cmd,%mem --sort=-%mem |
  head -n $(test $1 && echo $1 || echo 10)
}

function z() {
  zellij --layout ~/.config/zellij/layouts/layout1.yaml
}

# lg()
# {
#   export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir
#   lazygit "$@"
#   if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
#     cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
#     rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
#   fi
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
  /bin/ls -A "$dir" | sed "/^$patterns$/ d" | awk "{ print \"$dir/\"\$1 }"
}

# -----------------------------------------
#        C/C++: watch and run
# -----------------------------------------

function wmake() {
  local files
  files=(*.c)
  if [ ${#files[@]} = 0 ]; then
    echo "no file found to make!"
    return 1
  fi
  (($#)) && {
    exec="&& echo ------- starting ------- && ./$1 && echo ------- ending -------"
    shift
  }
  nodemon -w "${files[@]}" -e c,cc,cpp -x "make $exec"
}

function wjc() {
  # validation
  local err=

  if [ "${1:0:1}" = "-" ]; then
    local JDK="/usr/lib/jvm/java-${1:1}-openjdk"
    shift
  fi

  if [ ! "${1: -5}" = ".java" ]
  then err="Oops! you have to pass a java file as the 1st arg"
  elif [ ! -f "$1" ]
  then err="Oops! file not found: ./$1"; fi
  if [ "$err" ]; then echo "$err" >&2; return 1; fi

  local file=$1; shift
  local JDK=${JDK:-/usr/lib/jvm/default}
  local java="$JDK/bin/java"
  local javac="$JDK/bin/javac"
  nodemon -w "$file" -e c -x \
    "$javac" $JC_OPTIONS "$file" "&&" \
    "$java" $JC_OPTIONS "$file" "$@"
}

function jc() {
  # validation
  local err=

  if [ "${1[1]}" = "-" ]; then
    local JDK="/usr/lib/jvm/java-${1:1}-openjdk"
    shift
  fi

  if [ ! "${1: -5}" = ".java" ]
  then err="Oops! you have to pass a java file as the 1st arg"
  elif [ ! -f "$1" ]
  then err="file not found: ./$1"; fi
  if [ "$err" ]; then echo "$err" >&2; return 1; fi

  local file=$1; shift
  local JDK=${JDK:-/usr/lib/jvm/default}
  local java="$JDK/bin/java"
  local javac="$JDK/bin/javac"
  "$javac" $JC_OPTIONS "$file" &&
  "$java" $JC_OPTIONS "$file" "$@"
}

function wgc() {
  # validation
  local err=;local file=

  if [ ! "$1" ]
  then err="you have to pass the filename!"
  elif [ ! -f "$1.c" ]
  then err="file not found: ./$1.c"; fi
  if [ "$err" ]; then echo "$err" >&2; return 1; fi

  file=$1; shift
  nodemon -w "$file.c" -e c -x gcc "$file.c" -o "$file" "&&" "./$file" "$@"
}

function rgc() {
  # validation
  local err=; local file=
  if [ ! "$1" ]; then err="you have to pass the filename!";
  elif [ ! -f "$1.c" ]; then err="file not found: ./$1.c"; fi
  if [ "$err" ]; then echo "$err" >&2; return 1; fi
  # command to watch and compile
  file=$1; shift
  gcc "$file.c" -o "$file" && "./$file" "$@"
}

function wgcc() {
  # watch and compile, then execute the code
  local err=; local file=

  if [ ! "$1" ]; then err="you have to pass the filename!";
  elif [ ! -f "$1.cc" ] && [ ! -f "$1.cpp" ]
  then err="file not found: './$1.cc' and './$1.cpp'"; fi
  if [ "$err" ]; then echo "$err" >&2; return 1; fi

  file="$1"; shift

  if [ -f "$file.cc" ]
  then ext="cc"
  else ext="cpp"; fi

  nodemon -w "$file.$ext" -e $ext -x g++ "$file.$ext" -o "$file" "&&" "./$file" "$@"
}

function rgcc() {
  local err=; local file=

  if [ ! "$1" ]; then err="you have to pass the filename!";
  elif [ ! -f "$1.cc" ] && [ ! -f "$1.cpp" ]
  then err="file not found: \"./$1.cc\" and \"./$1.cpp\""; fi
  if [ "$err" ]; then echo "$err" >&2; return 1; fi

  file=$1; shift

  if [ -f "$file.cc" ]
  then ext="cc"
  else ext="cpp"; fi

  g++ "$file.$ext" -o "$file" && "./$file" "$@"
}
