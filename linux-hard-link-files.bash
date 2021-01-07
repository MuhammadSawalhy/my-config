#!/bin/bash

# detecting options
is_dry=0
for o in "$@"; do
  [ "$o" = "--dry" ] && is_dry=1
done

getrealpatterns() {
  for p in "$@"; do
    local neg=0
    [ $(expr index "$p" '!') = 1 ] && neg=1
    test $neg -eq 1 && _p=${p:1} || _p=$p
    test $neg -eq 1 && _neg='!' || _neg=''
    # it may be more than one path
    awk_expr="\"$_neg\"\$i\"\\n\"" # e.g.: "!"$i"\n"
    _p=`eval echo "$_p" | awk "{for (i=1; i<=NF; i++) printf $awk_expr}"`
    echo "$_p" # quoted inside "" to make echo lines seperately
  done
}

[ $is_dry = 0 ] && rm -rf ./linux/ # not dry && remove dir
patterns=`getrealpatterns $(sed "/^\s*#\|^\s*$/ d" ./linux-linked-files.txt)`
files=(`DRY=$is_dry node ./linux-linked-files.js $patterns`)

for f in "${files[@]}"; do
  [ $is_dry = 1 ] && echo "$f" && continue
  ln "$HOME/$f" "./linux/$f"
done

