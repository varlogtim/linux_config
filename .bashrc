# PyEnv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"

# Aliases
alias ls='ls --color=always'
alias grep='grep --color=always'
alias grepc='grep --color=never'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -iv'
alias less='less -R'
alias make='make'  # use 8 jobs
alias ct='ctags -R -o ~/.cache/ctags ./'
alias xc='xclip'
alias ca='conda activate'
alias cad='conda activate dev'


# Functions
FUNC_DIR=$HOME/thinkpad/tools/bash_funcs
for f in $FUNC_DIR/*; do
    source $f
done

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

# XXX Add these to ~/.config/.determined.bashrc
alias purgeDevDb='docker kill determined_db; docker container rm determined_db'
alias postgresrm='sudo rm -rf /home/ttucker/.postgres'
alias dcl='devcluster -c ~/.devcluster.yaml'


export TERMINFO="/usr/share/terminfo"

# Paths
export PATH=$HOME/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=/usr/lib/jvm/java-11-openjdk/bin/:$PATH
export PATH=$HOME/.local/bin:$PATH

export TZ='America/New_York';

# A better git log
#git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


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


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ttucker/tmp/src/google-cloud-sdk/path.bash.inc' ]; then . '/home/ttucker/tmp/src/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ttucker/tmp/src/google-cloud-sdk/completion.bash.inc' ]; then . '/home/ttucker/tmp/src/google-cloud-sdk/completion.bash.inc'; fi
