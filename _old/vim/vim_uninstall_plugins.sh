#!/bin/bash
rm -rfv $HOME/.vim/plugged
vim -c "PlugClean" -c "qall"
