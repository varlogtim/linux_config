# PyEnv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"

# Aliases
alias ls='ls --color=always'
alias grepc='grep --color=always'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -iv'
alias less='less -R'
alias make='make'  # use 8 jobs
alias ct='ctags -R -o ~/.cache/ctags ./'
alias xc='xclip'
alias ca='conda activate'
alias cad='conda activate py-3.9.17'
alias cad38='conda activate py-3.8.10'
alias cad37='conda activate py-3.7.11-2'
alias cad_genai='conda activate genAI_py3.10'
alias dev='conda activate dev-py3.12'
alias nodet='conda activate py-3.9.17-NO-DETERMINED'
alias cad310='conda activate cad310'
alias dact='conda deactivate'
alias dcl='devcluster -c ~/tmp/determined/.devcluster.yaml'
alias token='export TOKEN=$(curl -X POST -d "{\"username\": \"admin\", \"password\": \"\"}" ${DET_MASTER}/api/v1/auth/login | jq ".token" | sed "s/\"//g")'
alias mnistp="det e create ~/determined/examples/tutorials/mnist_pytorch/const.yaml ~/determined/examples/tutorials/mnist_pytorch/"
alias dt='date +"%Y%m%dT%H%M%S"'
alias desc='det e describe'
alias rmdb='sudo rm -vrf ~/.postgres/'
alias topmem='top -bn1 -o%MEM | head -n 20'
alias wakeup='export DISPLAY=:0; xrandr --output DP-0 --mode 3840x2160'
alias k='kubectl'
alias jiggle='while true; do DISPLAY=:0 xdotool mousemove $(( 1 + $RANDOM % 1920 )) $(( 1 + $RANDOM % 1080 )); sleep 1; done'

# function gitfullblame { git blame $1 | cut -d" " -f1 | uniq | while read sha; do git show $sha; done; }
# export -f gitfullblame
#
# Make function for this:
# det e lt --csv 389 |grep -E '^[0-9]+'

# Browser
export BROWSER="/usr/bin/chromium"

# Display stuff:
export GDK_SCALE=0.5

# Emacs mode
set -o emacs

# Less and Pager
#export LESS="--use-color -M -R -X -W"
#export PAGER=less


# LD_LIBRARY_PATH  XXX You should probably dynamically set these
export LD_LIBRARY_PATH=/usr/lib/modules/$(uname -r)/build/include/:/usr/lib/modules/$(uname -r)/build/arch/x86/include/:/usr/lib/modules/$(uname -r)/build/arch/x86/include/generated/:/usr/include/
export LIBRARY_PATH=/usr/lib/modules/$(uname -r)/build/include/:/usr/lib/modules/$(uname -r)/build/arch/x86/include/:/usr/lib/modules/$(uname -r)/build/arch/x86/include/generated/:/usr/include/
export C_INCLUDE=/usr/lib/modules/$(uname -r)/build/include/:/usr/lib/modules/$(uname -r)/build/arch/x86/include/:/usr/lib/modules/$(uname -r)/build/arch/x86/include/generated/:/usr/include/



# Functions
FUNC_DIR=$HOME/thinkpad/tools/bash_funcs
for f in $FUNC_DIR/*; do
    source $f
done

function dget {
    curl -H "Authorization: Bearer ${TOKEN}" -H  "accept: application/json" -X GET "${DET_MASTER}${1}"
}

# Variables
export CSCOPE_EDITOR=/usr/bin/vim
export EDITOR=/usr/bin/vim

# Browser
xdg-mime default browser.desktop x-scheme-handler/http
xdg-mime default browser.desktop x-scheme-handler/https


# bash-completion
BASH_COMPLETION='/usr/share/bash-completion/bash_completion'
if [ -e ${BASH_COMPLETION} ]; then
    source ${BASH_COMPLETION}
fi

# Node.js
# https://stackoverflow.com/questions/18088372/how-to-npm-install-global-not-as-root
export NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"

# NVM for Node.js
# https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Additional bashrc's
for rc in $HOME/.config/.*.bashrc; do
    source $rc
done

# Determined
# XXX Add these to ~/.config/.determined.bashrc
alias postgresrm='sudo rm -rf /home/ttucker/.postgres'
alias dcl='devcluster -c ~/.devcluster.yaml'

export TERMINFO="/usr/share/terminfo"

# Go lang
# curl -LO https://dl.google.com/go/go1.17.2.linux-amd64.tar.gz 
# curl -LO https://go.dev/dl/go1.18.10.linux-amd64.tar.gz
# export GOROOT="$HOME/tmp/src/golang/go-1.20.1"
# export GOPATH="$HOME/tmp/go_roots/go-1.20.1"
export GOROOT="$HOME/tmp/src/golang/go-1.21.0"
export GOPATH="$HOME/tmp/go_roots/go-1.21.0"
# export GOROOT="$HOME/tmp/src/golang/go-1.22.1"
# export GOPATH="$HOME/tmp/go_roots/go-1.22.1"
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# System Go
#export PATH=$HOME/go/bin:$PATH

# Paths
export PATH=$HOME/bin:$PATH
export PATH=/usr/lib/jvm/java-11-openjdk/bin/:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=/home/ttucker/tmp/determined/dev-scripts:$PATH



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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ttucker/tmp/src/google-cloud-sdk/path.bash.inc' ]; then . '/home/ttucker/tmp/src/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ttucker/tmp/src/google-cloud-sdk/completion.bash.inc' ]; then . '/home/ttucker/tmp/src/google-cloud-sdk/completion.bash.inc'; fi
. "$HOME/.cargo/env"


# NVM
# /usr/share/nvm/init-nvm.sh
[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/install-nvm-exec
