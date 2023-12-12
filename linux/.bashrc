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

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --strip-cwd-prefix'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.volta/bin:$PATH"
