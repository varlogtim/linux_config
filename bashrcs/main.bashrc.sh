# Emacs mode
set -o emacs

# Aliases
alias ls='ls --color=always'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -iv'
alias less='less -R'
alias grepc='grep --color=always'
alias ct='ctags -R -o ~/.cache/ctags ./'
alias k='kubectl'
alias dt='date +"%Y%m%dT%H%M%S"'
alias topmem='top -bn1 -o%MEM | head -n 20'

# TODO:
# - Break specific components out into separate bashrc files and/or functions.
# - Figure out a sway bind to launch different terminals with different vars evaluated.
#   - The use case here is that I want a key bind for my work dev environment.

# Conda Envs
alias dev311='conda activate dev-py3.11'

# MLIS
alias mlis="conda activate dev-py3.11; source $HOME/tmp/hpe/virtual_envs/aioli/bin/activate"
alias dbrm_aioli="sudo rm -rf /home/ttucker/.postgres-aioli-test"

# Browser
export BROWSER="/usr/bin/firefox"

# Variables
export CSCOPE_EDITOR=/usr/bin/vim
export EDITOR=/usr/bin/vim


# Include paths
export LD_LIBRARY_PATH=/usr/lib/modules/$(uname -r)/build/include/:/usr/lib/modules/$(uname -r)/build/arch/x86/include/:/usr/lib/modules/$(uname -r)/build/arch/x86/include/generated/:/usr/include/
export LIBRARY_PATH=/usr/lib/modules/$(uname -r)/build/include/:/usr/lib/modules/$(uname -r)/build/arch/x86/include/:/usr/lib/modules/$(uname -r)/build/arch/x86/include/generated/:/usr/include/
export C_INCLUDE=/usr/lib/modules/$(uname -r)/build/include/:/usr/lib/modules/$(uname -r)/build/arch/x86/include/:/usr/lib/modules/$(uname -r)/build/arch/x86/include/generated/:/usr/include/


# Functions
FUNC_DIR=$HOME/thinkpad/tools/bash_funcs
if [ -f $FUNC_DIR ]; then 
    for f in $FUNC_DIR/*; do
        source $f
    done
fi

# bash-completion
BASH_COMPLETION='/usr/share/bash-completion/bash_completion'
if [ -e ${BASH_COMPLETION} ]; then
    source ${BASH_COMPLETION}
fi

# NVM for Node.js
# https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export TERMINFO="/usr/share/terminfo"
# Go lang
# curl -LO https://go.dev/dl/go1.24.1.linux-amd64.tar.gz
export GOROOT="$HOME/tmp/golang/go-1.24.1"
export GOPATH="$HOME/tmp/golang/go_roots/go-1.24.1"
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# System Go
#export PATH=$HOME/go/bin:$PATH

# Paths
export PATH=$HOME/bin:$PATH
export PATH=/usr/lib/jvm/java-11-openjdk/bin/:$PATH
export PATH=$HOME/.local/bin:$PATH

export TZ='America/New_York';

# A better git log
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ttucker/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ttucker/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ttucker/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ttucker/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
