#!/bin/bash

################ ---------------------
### aliases
################ ---------------------

alias r="ranger"
alias gpo="git push -u origin"
alias myp="cd ~/Desktop/myp/"
alias myc="cd ~/myconfig"
alias edu="cd ~/Desktop/edu/edu1"
alias saveimage="xclip -sel clip -t image/png -o" 

alias antlr4='java -jar /usr/local/lib/antlr-4.9-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'
export CLASSPATH=".:/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH"

################ ---------------------
### default apps
################ ---------------------

export EDITOR=nvim

################ ---------------------
### my own scripts
################ ---------------------

# tmux has to be working
ide() {
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
lae() {
  ls -a | sed -e "/$1/ d" | sed '1,2d'
}

wgcc() {
  local err=""
  # validation
  if [ ! $1 ]; then err="at least, you have to pass a filepath!";
  elif [ ! -e $1 ]; then err="file not found: $1"; fi
  if [ $err ]; then echo $err >&2; return 1; fi
  # command to watch and compile
  nodemon -w $1 -e c -x gcc "$@"
}

