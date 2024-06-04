export CLICOLOR=1 
export LSCOLORS=ExFxDxegcxabagacad

alias ls='ls --color=auto'
alias python=python3

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt autocd beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/chris/.zshrc'

# Turnoff the beep sound 
unsetopt BEEP

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
alias vi="nvim"

PROMPT='chris:%2~%# '

# Ensure that zsh history is writen immediatly
setopt INC_APPEND_HISTORY

path+=('/Users/chris/.local/bin')

export NVM_DIR="/home/chris/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Turing off telemetry for dotnetcore 
export DOTNET_CLI_TELEMETRY_OPTOUT=1
PATH="$PATH:/Users/chris/.dotnet/tools"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin"

# Alias things to use rlwap
alias idris='rlwrap idris2'
PATH="$HOME/.idris2/bin:$PATH"
alias bb='rlwrap bb'
alias R=radian
alias sbcl='rlwrap sbcl'
alias swank="sbcl --eval '(ql:quickload :swank)'  --eval '(swank:create-server :dont-close t)'"

# Use improved R repl 

PATH="$HOME/.ghcup/bin:$PATH"
path+=('/Applications/Racket v8.9/bin')

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/Users/chris/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<

# Setting up pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# MacOS Fn-Delete behave properly
bindkey "^[[3~" delete-char

# Turn on stricter checking of raw pointers by miri 
export MIRIFLAGS="-Zmiri-tag-raw-pointers"
