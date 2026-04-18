export CLICOLOR=1 
export LSCOLORS=ExFxDxegcxabagacad
alias ls='ls --color=auto'

unsetopt autocd beep

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
export HISTFILE="$HOME/.histfile"
HISTSIZE=1000
SAVEHIST=1000
setopt INC_APPEND_HISTORY
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/chris/.zshrc'

# Turnoff the beep sound 
unsetopt BEEP

autoload -Uz compinit
compinit
# End of lines added by compinstall

PROMPT='chris:%2~%# '

export NVM_DIR="/home/chris/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Turing off telemetry for dotnetcore 
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Aliases
alias python=python3
alias vi="nvim"
alias R=radian
alias swank="sbcl --eval '(ql:quickload :swank)' --eval '(swank:create-server :dont-close t)'"

alias idris='rlwrap idris2'
alias bb='rlwrap bb'
alias sbcl='rlwrap sbcl'

# MacOS Fn-Delete behave properly
bindkey "^[[3~" delete-char

export CHPL_HOME="/Users/chris/Code/Experiments/Chapel/chapel"

# Turn on stricter checking of raw pointers by miri 
export MIRIFLAGS="-Zmiri-tag-raw-pointers"

# Setting up the path
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.dotnet/tools"
PATH="$PATH:$HOME/.idris2/bin"
PATH="$PATH:$HOME/.juliaup/bin"
PATH="$PATH:$CHPL_HOME/bin/darwin-arm64/"
PATH="$PATH:$HOME/.local/share/alire/toolchains/gprbuild_24.0.1_6f6b6658/bin"
PATH="$PATH:$HOME/.local/share/alire/toolchains/gnat_native_14.2.1_cc5517d6/bin"
export PATH

# make sure we find the more up-to-date version of clang first
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
