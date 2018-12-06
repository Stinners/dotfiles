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

# OPAM configuration
. /home/chris/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

export NVM_DIR="/home/chris/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

alias vi=nvim
alias vim=nvim
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Making portal work 
# Use -z flag in cut is to make it ignore newline characters
function fe {
    output=$(/home/chris/Code/Rust/portal/target/release/portal $*)
    first_word=$(echo -n $output | awk -v RS="" '{print $1}')
    if [[ $first_word == "_MOVE_" ]]; then 
         rest=$(echo -n $output | cut -c 8-)         # Remove the _MOVE_ part
         cd $rest                             
    elif [[ $first_word == "_PRINT_" ]]; then 
         rest=$(echo -n $output | cut -z -c 9-)      # Remove the _PRINT_ part   
         echo $rest
    else 
        echo $output 
    fi 
}

# Ensure that history is writen immediatly
setopt INC_APPEND_HISTORY

export PATH="$PATH:/home/chris/Downloads/swift-4.2-CONVERGENCE-ubuntu18.04/usr/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Turing off telemetry for dotnetcore 
export DOTNET_CLI_TELEMETRY_OPTOUT=1

