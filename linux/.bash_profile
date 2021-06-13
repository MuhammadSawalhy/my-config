
# -----------------------------------------
#        extra for some apps
# -----------------------------------------

alias antlr4='java -jar /usr/local/lib/antlr-4.9-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'
export CLASSPATH=".:/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH"

source /home/ms/.config/broot/launcher/bash/br
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:~/.cargo/bin:$PATH"
