#!/bin/bash

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
  [ "$o" = "-d" ] && is_dry=1 && continue
  [ "$o" = "--dry" ] && is_dry=1 && continue
  [ "$o" = "--dry" ] && is_dry=1 && continue
  [ "$o" = "-r" ] && is_reverse=1 && continue
  [ "$o" = "--reverse" ] && is_reverse=1 && continue
  [ "$o" = "-f" ] && is_force=1 && continue
  [ "$o" = "--force" ] && is_force=1 && continue
  [ $(is_merged_arg $o r d) ] && is_dry=1 && is_reverse=1 && continue
  [ $(is_merged_arg $o r f) ] && is_force=1 && is_reverse=1 && continue
  [ $(is_merged_arg $o d f) ] && is_dry=1 && is_force=1 && continue
  [ $(is_merged_arg $o r d f) ] && is_dry=1 && is_force=1 && is_reverse=1 && continue
  echo unknown options \"$o\" >&2; exit 1
done

getrealpatterns() {
  for p in "$@"; do
    local neg= # reset it as it still has the previous value
    [ $(expr index "$p" '!') == 1 ] && _neg='!' || _neg='' # put any value, it doesn't matter
    test $_neg && _p=${p:1} || _p=$p
    # it may be more than one path
    awk_expr="\"$_neg\"\$i\"\\n\"" # e.g.: "!"$i"\n"
    _p=`eval echo "$_p" | awk "{for (i=1; i<=NF; i++) printf $awk_expr}"`
    echo $_p
  done
}

[ ! $is_dry ] && [ ! $is_reverse ] && rm -rf linux/ # not dry && remove dir

NODE_DRY=$(test $is_dry && echo 1)
NODE_REVERSE=$(test $is_reverse && echo 1)

patterns=$(sed "/^\s*#\|^\s*$/ d" ./linux-linked-files.txt) # remove void lines and comments
patterns=`getrealpatterns $patterns` # expand wildcard patterns
files=(`DRY=$NODE_DRY REVERSE=$NODE_REVERSE node ./linux-linked-files.js $patterns`) # indexed array

for f in "${files[@]}"; do
  echo "$f"
  [ $is_dry ] && continue
  [ ! $is_reverse ] && ln "$HOME/$f" "./linux/$f" || ln "./linux/$f" "$HOME/$f"
done

