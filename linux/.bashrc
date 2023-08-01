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
[ -f ~/.fzf.bash ] && . ~/.fzf.bash
fpath+=~/.zfunc

source "$HOME/.cargo/env"
export PATH="$HOME/.volta/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

