#!/bin/bash
PREPEND="$1"
if [[ -z $ORIG_PS1 ]]; then
    ORIG_PS1="$PS1"
fi
export PS1="${PREPEND} ${ORIG_PS1}"
