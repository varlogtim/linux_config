# Emacs mode
set -o emacs


export TZ='America/New_York'
export XDG_CURRENT_DESKTOP=sway
export BROWSER="/usr/bin/firefox"
export CSCOPE_EDITOR=/usr/bin/vim
export EDITOR=/usr/bin/vim
export TERMINFO="/usr/share/terminfo"
export KUBE_EDITOR="nvim"

# Aliases
if command -v lsd >/dev/null 2>&1; then
    alias ls='lsd'
else
    alias ls='ls --color=always'
fi
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -iv'
alias less='less -R'
alias grepc='grep --color=always'
alias ct='ctags -R -o ~/.cache/ctags ./'
alias k='kubectl'
alias dt='date +"%Y%m%dT%H%M%S"'
alias topmem='top -bn1 -o%MEM | head -n 20'
alias wlc='wl-copy'

# TODO:
# - Break specific components out into separate bashrc files and/or functions.
# - Create a script which populates direnv files with specific versions of utils.


# Include paths
export LD_LIBRARY_PATH=/usr/lib/modules/$(uname -r)/build/include/:/usr/lib/modules/$(uname -r)/build/arch/x86/include/:/usr/lib/modules/$(uname -r)/build/arch/x86/include/generated/:/usr/include/
export LIBRARY_PATH=/usr/lib/modules/$(uname -r)/build/include/:/usr/lib/modules/$(uname -r)/build/arch/x86/include/:/usr/lib/modules/$(uname -r)/build/arch/x86/include/generated/:/usr/include/
export C_INCLUDE=/usr/lib/modules/$(uname -r)/build/include/:/usr/lib/modules/$(uname -r)/build/arch/x86/include/:/usr/lib/modules/$(uname -r)/build/arch/x86/include/generated/:/usr/include/



##########################################
# Global Environment Setup
#

### bash-completion
BASH_COMPLETION='/usr/share/bash-completion/bash_completion'
if [ -e ${BASH_COMPLETION} ]; then
    source ${BASH_COMPLETION}
fi

### Bash History
HISTSIZE=100  # commands in memory
HISTFILESIZE=100000  # commands in history file.
# NOTE: fzf searches the history file, so no need to increase in memory histsize.
shopt -s histappend  # append to HISTFILE instead of overwriting.
# Hack to merge history across terminals.
# NOTE: a command has to be run in the terminal in order for them to sync.
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

### Fuzzy Finder
if [ -e /usr/share/fzf/key-bindings.bash ]; then
    source /usr/share/fzf/key-bindings.bash
fi
if [ -e /usr/share/fzf/completion.bash ]; then
    source /usr/share/fzf/completion.bash
fi

### Direnv
if [ -x "$(command -v direnv)" ]; then
    eval "$(direnv hook bash)"
fi

### Git Config (TODO: look into a better way of setting that or isolating thise)
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias lg-tag "log --color --graph  --tags --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global core.editor "nvim"


##########################################
# Global Language Paths
#
# TODO: 
#  - setup direnvs for each, where appropriate.
#  - create well-named symlinks, i.e., global -> somever
#

# NVM for Node.js
# https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Golang
# curl -LO https://go.dev/dl/go1.24.1.linux-amd64.tar.gz
export GOROOT="$HOME/tmp/golang/go-1.24.1"
export GOPATH="$HOME/tmp/golang/go_roots/go-1.24.1"
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Java
export PATH=$HOME/bin:$PATH
export PATH=/usr/lib/jvm/java-11-openjdk/bin/:$PATH
export PATH=$HOME/.local/bin:$PATH

# Krew (kubectl plugins)
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

##########################################
# Extended Bashrcs:
#
# TODO:
# - Add host specific bashrc
BASHRC_DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")

# Prompt
if [ -f "${BASHRC_DIR}/prompt.bashrc.sh" ]; then
    source "${BASHRC_DIR}/prompt.bashrc.sh"
fi

# Work Aliases
if [ -f "${BASHRC_DIR}/work.bashrc.sh" ]; then
    source "${BASHRC_DIR}/work.bashrc.sh"
fi


