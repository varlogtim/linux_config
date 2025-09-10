#!/bin/bash
pf() {
    PREPEND="$1"
    if [[ -z $ORIG_PS1 ]]; then
        ORIG_PS1="$PS1"
    fi

    if [[ -z "$PREPEND" ]]; then
        export PS1=$ORIG_PS1
    else
        export PS1="${PREPEND} ${ORIG_PS1}"
    fi
}
