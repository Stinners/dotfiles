export CLICOLOR=1 
export LSCOLORS=ExFxDxegcxabagacad

alias ls='ls --color=auto'

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt autocd beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/chris/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

PROMPT='%n:%2~%# '

export NVM_DIR="/home/chris/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

alias vi=~/.local/bin/nvim
alias vim=~/.local/bin/nvim

alias python=python3

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Ensure that history is writen immediatly
setopt INC_APPEND_HISTORY

# Turing off telemetry for dotnetcore 
export DOTNET_CLI_TELEMETRY_OPTOUT=1

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Setting GOPATH 
# This is just to stop go from cluttering my home directory
export GOPATH=$HOME/Code/Go 

# Aliasing idris properly 
alias idris='rlwrap idris2'
# Adding Lean infristucture to the PATH 
export PATH="$PATH:$HOME/.elan/bin"
