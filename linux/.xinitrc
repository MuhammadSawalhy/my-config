#!/bin/sh

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
[[ -f ~/.us.Xmodmap ]] && xmodmap ~/.us.Xmodmap
setxkbmap -layout us,ar \
  -option grp:win_space_toggle \
  -option caps:swapescape
screenlayouts
nitrogen --restore &
picom &
clipmenud &
dwm-iconbar &
copyq
megasync && megasync
wal
exec dwm

