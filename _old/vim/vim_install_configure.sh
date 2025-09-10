#!/bin/bash

# Install Vim-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# PlugInstall
vim -c "PlugInstall --sync" -c "qall"
