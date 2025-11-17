#!/bin/bash

# # see https://unix.stackexchange.com/a/295652/332452
# source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
# # see https://wiki.archlinux.org/title/GNOME/Keyring#xinitrc
# eval "$(/usr/bin/gnome-keyring-daemon --start)"
# export SSH_AUTH_SOCK
# # see https://github.com/NixOS/nixpkgs/issues/14966#issuecomment-520083836
# mkdir -p "$HOME"/.local/share/keyrings
# 
# # https://bbs.archlinux.org/viewtopic.php?pid=1092965#p1092965
# export _JAVA_AWT_WM_NONREPARENTING=1
# # to fix this issue:
# #   1. https://stackoverflow.com/a/64370938
# #   2. https://github.com/MicrosoftDocs/live-share/issues/3875
# export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

# [[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
# [[ -f ~/.us.Xmodmap ]] && xmodmap ~/.us.Xmodmap
# setxkbmap -layout us,ar \
#   -option grp:win_space_toggle \
#   -option caps:swapescape

screenlayouts

