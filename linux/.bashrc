#
# ~/.bashrc
#

PS1='[\u@\h \W]\$ '

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

export GPG_TTY=$(tty)

##############################################
### OTHER SCIPRTS AND PROGRAMS BINS
##############################################

[ -f ~/.bash_profile ] && . ~/.bash_profile

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export MANPATH="$(manpath -g):/opt/texlive/2021/texmf-dist/doc/man"
export INFOPATH="$INFOPATH:/opt/texlive/2021/texmf-dist/doc/info"
export PATH="$PATH:/opt/texlive/2021/bin/x86_64-linux"
export DENO_INSTALL="/home/ms/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

. "$HOME/.cargo/env"
source /home/ms/.config/broot/launcher/bash/br
