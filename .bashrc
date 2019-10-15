# Aliases
alias ls='ls --color=always'
alias grep='grep --color=always'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -i'

# Variables
export CSCOPE_EDITOR=/usr/bin/vim

# bash-completion
BASH_COMPLETION='/usr/share/bash-completion/bash_completion'
if [ -e ${BASH_COMPLETION} ]; then
    source ${BASH_COMPLETION}
fi

# Additional bashrc's
for rc in $HOME/.config/.*.bashrc; do
    source $rc
done
