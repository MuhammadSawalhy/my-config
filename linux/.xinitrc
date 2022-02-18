#!/bin/sh

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
[[ -f ~/.us.Xmodmap ]] && xmodmap ~/.us.Xmodmap
setxkbmap -layout us,ar \
  -option grp:win_space_toggle \
  -option caps:swapescape
screenlayouts
wal
nitrogen --restore &
picom &
dwm-iconbar &
exec dwm

