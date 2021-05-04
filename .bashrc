# Aliases
alias ls='ls --color=always'
alias grep='grep --color=always'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -iv'

# Variables
export CSCOPE_EDITOR=/usr/bin/vim

# Node.js
# https://stackoverflow.com/questions/18088372/how-to-npm-install-global-not-as-root
export NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"

# Additional bashrc's
for rc in $HOME/.config/.*.bashrc; do
    source $rc
done

# Paths
export PATH=$HOME/bin:$PATH
