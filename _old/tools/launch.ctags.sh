#!/bin/bash
CTAGS_FILE="$HOME/ctags"
ctags \
    -o $CTAGS_FILE \
    --languages=all \
    --exclude=*.js \
    --exclude=*.mjs \
    --exclude=*build* \
    --exclude=*.json \
    --exclude=*.html \
    --exclude=*.bin* \
    -R \
    $1
