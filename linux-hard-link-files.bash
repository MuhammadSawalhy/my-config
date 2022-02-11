#!/bin/bash

print_help () {
  echo 'OPTIONS:
    --force       | all files will be linked forcely "ln -f"
    --dry, -d     | no real physical changes will happen
    --fill, -f    | only missing files will be linked (default when HOME -> ./linux)
    --reverse, -r | files in ./linux will be linked to your $HOME (--fill is not activated)'
}

# detecting options
is_merged_arg() {
  arg=${1:1}; shift
  test `expr length $arg` -eq $# || return 1;
  for a in $@; do
    test `expr index $arg $a` -gt 0 || return 1
  done
  echo 1
}

for o in "$@"; do

  [ "$o" = "-h" ]        && is_help=1    && break
  [ "$o" = "--help" ]    && is_help=1    && break
  [ "$o" = "-d" ]        && is_dry=1     && continue
  [ "$o" = "--dry" ]     && is_dry=1     && continue
  [ "$o" = "--dry" ]     && is_dry=1     && continue
  [ "$o" = "-r" ]        && is_reverse=1 && continue
  [ "$o" = "--reverse" ] && is_reverse=1 && continue
  [ "$o" = "-f" ]        && is_fill=1    && continue
  [ "$o" = "--fill" ]    && is_fill=1    && continue
  [ "$o" = "--force" ]   && is_force=1   && continue

  [ $(is_merged_arg $o r d) ]   && is_dry=1  && is_reverse=1 && continue
  [ $(is_merged_arg $o r f) ]   && is_fill=1 && is_reverse=1 && continue
  [ $(is_merged_arg $o d f) ]   && is_dry=1  && is_fill=1    && continue
  [ $(is_merged_arg $o r d f) ] && is_dry=1  && is_fill=1    &&
    is_reverse=1 && continue

  [ $(is_merged_arg $o r h) ]     && is_help=1 && continue
  [ $(is_merged_arg $o f h) ]     && is_help=1 && continue
  [ $(is_merged_arg $o d h) ]     && is_help=1 && continue
  [ $(is_merged_arg $o r d h) ]   && is_help=1 && continue
  [ $(is_merged_arg $o r f h) ]   && is_help=1 && continue
  [ $(is_merged_arg $o d f h) ]   && is_help=1 && continue
  [ $(is_merged_arg $o r d f h) ] && is_help=1 && continue

  echo unknown options \"$o\" >&2; exit 1

done

((is_help)) && print_help && exit

if [ $is_fill ] && [ $is_force ]; then
  >&2 echo can\'t pass both force and fill options!
  exit 1
elif [ ! $is_force ] && [ ! $is_reverse ]; then
  is_fill=1
fi

[ $is_reverse ] &&
readarray -t patterns < <(find linux -type f | sed 's/^linux\///') ||
readarray -t patterns < <(sed "/^\s*#\|^\s*$/ d" ./linux-linked-files.txt) # remove void lines and comments

# echo "${patterns[@]}"; exit
# echo DRY=$is_dry REVERSE=$is_reverse FORCE=$is_force FILL=$is_fill; exit
# DRY=$is_dry REVERSE=$is_reverse FORCE=$is_force FILL=$is_fill \
#   node inspect ./linux-linked-files.js "${patterns[@]}"; exit

files=$(
  DRY=$is_dry REVERSE=$is_reverse \
  FORCE=$is_force FILL=$is_fill \
  node ./linux-linked-files.js "${patterns[@]}"
)

(($?)) && exit 1 # exit when an error detected

readarray -t files <<< "$files"

# echo ${!files[@]}
# echo "${files[@]}"; exit

force_opt=`test $is_force && echo '-f'`

for f in "${files[@]}"; do
  echo "$f"
  [ $is_dry ] && continue
  [ ! $is_reverse ] && 
    ln $force_opt "$HOME/$f" "./linux/$f" ||
    ln $force_opt "./linux/$f" "$HOME/$f"
done

