# Aliases
alias ls='ls --color=always'
alias grep='grep --color=always'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -i'

# Variables
export CSCOPE_EDITOR=/usr/bin/vim

# Additional bashrc's
for rc in $HOME/.config/.*.bashrc; do
    source $rc
done
