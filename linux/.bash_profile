#!/bin/bash

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
alias pasteimage="xclip -sel clip -t image/png -o"
alias copyimage="xclip -sel clip -t image/png"
alias imgptoc="xclip -sel p -t image/png -o | xclip -sel clip -t image/png"
# to paste the image itself in obsidian, I don't want to use the online version
alias imgctoc="xclip -sel clip -t image/png -o | xclip -sel clip -t image/png"
alias clipptoc="xclip -sel p -o | xclip -sel clip"
alias cliprev="xclip -sel p -t UTF8_STRING -o | rev | xclip -sel clip -t UTF8_STRING"

alias myp="cd ~/myp/"
alias myc="cd ~/my-config"
alias edu="cd ~/Documents/edu/2nd-2"

alias yws="yarn workspace"
alias ywsf="yarn workspaces foreach"
alias ywsi="yarn workspaces foreach --include"
alias interact="python3 ~/myp/problem-solving/.stress-testing/interact.py"

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
  /bin/ls -A "$dir" | sed "/^$patterns$/ d" | awk "{ print \"$dir/\"\$0 }"
}

# -----------------------------------------
#        C/C++: watch and run
# -----------------------------------------

GXX="-DSAWALHY"

function ensure-file() {
  set -e
  local err
  local file_ext
  local file_path
  local real_ext
  local bin

  file_path="$1"; shift

  while (($#)); do
    file_ext="$1"; shift
    real_ext="${file_path: -$((${#file_ext} + 1))}" # +1 for the dot
    if [ "$real_ext" = ".$file_ext" ]; then
      bin="${file_path:0:-${#real_ext}}"
      break
    fi
  done

  if [ ! "$bin" ]; then
    if [ -f "$file_path" ]; then
      echo "file is not supported for this command: $file" >&2
    else
      echo "file not found: $file" >&2
    fi
    return 1
  fi

  echo "$bin"
}

function rgcc() {
  local bin
  local file="$1"
  bin="$(ensure-file "$file" c)"
  if [ ! "$bin" ]; then return 1; fi
  bin="$(realpath "$bin")"

  gcc "$GXX" "$file" -o "$bin" && "$bin" "$@"
}

function wgcc() {
  local bin
  local file="$1"
  bin="$(ensure-file "$file" c)"
  if [ ! "$bin" ]; then return 1; fi
  bin="$(realpath "$bin")"

  nodemon -w "$file" -x gcc "$GXX" "$file" -o "$bin" "&&" "$bin" "$@"
}

function rg++() {
  local bin
  local file="$1"
  bin="$(ensure-file "$file" cc cpp)"
  if [ ! "$bin" ]; then return 1; fi
  bin="$(realpath "$bin")"

  shift
  g++ "$GXX" "$file" -o "$bin" && "$bin" "$@"
}

function wg++() {
  # watch and compile, then execute the code
  local bin
  local file="$1"
  bin="$(ensure-file "$file" cc cpp)"
  if [ ! "$bin" ]; then return 1; fi
  bin="$(realpath "$bin")"

  shift
  nodemon -w "$file" -x g++ "$GXX" "$file" -o "$bin" "&&" "$bin" "$@"
}

function rjava() {
  if [ "${1[1]}" = "-" ]; then
    local JDK="/usr/lib/jvm/java-${1:1}-openjdk"
    shift
  fi

  local bin
  local file=$1; shift
  local JDK=${JDK:-/usr/lib/jvm/default}
  local java="$JDK/bin/java"
  local javac="$JDK/bin/javac"

  bin="$(ensure-file "$file" java)"
  if [ ! "$bin" ]; then return 1; fi

  shift
  "$javac" $JC_OPTIONS "$file" &&
  "$java" $JC_OPTIONS -cp "$(dirname "$bin")" "$(basename "$bin")" "$@"
}

function wjava() {
  if [ "${1[1]}" = "-" ]; then
    local JDK="/usr/lib/jvm/java-${1:1}-openjdk"
    shift
  fi

  local bin
  local file=$1; shift
  local JDK=${JDK:-/usr/lib/jvm/default}
  local java="$JDK/bin/java"
  local javac="$JDK/bin/javac"

  bin="$(ensure-file "$file" java)"
  if [ ! "$bin" ]; then return 1; fi

  nodemon -w "$file" -e c -x \
    "$javac" $JC_OPTIONS "$file" "&&" \
    "$java" $JC_OPTIONS -cp "$(dirname "$bin")" "$(basename "$bin")" "$@"
}

function wpy() {
  local bin
  local file=$1; shift
  bin="$(ensure-file "$file" py)"
  if [ ! "$bin" ]; then return 1; fi

  nodemon -w "$file" -e c -x python "$file"
}
