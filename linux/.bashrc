# ~/.bashrc

PS1='[\u@\h \W]\$ '

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

export GPG_TTY=$(tty)

##############---------------------------------
## import other script files
##############---------------------------------

[ -f ~/.bash_profile ] && . ~/.bash_profile
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
fpath+=~/.zfunc

PATH="/home/ms/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/ms/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/ms/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/ms/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/ms/perl5"; export PERL_MM_OPT;

export DENO_INSTALL="/home/ms/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$PATH:/opt/texlive/2021/bin/x86_64-linux"
export MANPATH="$(manpath -g):/opt/texlive/2021/texmf-dist/doc/man"
export INFOPATH="$INFOPATH:/opt/texlive/2021/texmf-dist/doc/info"

source "$HOME/.cargo/env"
source /home/ms/.config/broot/launcher/bash/br
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

