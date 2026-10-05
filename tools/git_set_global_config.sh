#!/usr/bin/env bash
#
# Set my global git config options (~/.gitconfig).
#
# Run once per machine (and again after editing this file). These used to run
# from bashrcs/main.bashrc.sh on every shell start, which rewrote ~/.gitconfig
# each time and spammed "error: key does not contain a section: alias" because
# of a missing dot in "alias.lg-tag".
#
# Usage: tools/git_set_global_config.sh
set -euo pipefail

FORMAT="%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"

git config --global alias.lg     "log --color --graph --pretty=format:'${FORMAT}' --abbrev-commit"
git config --global alias.lg-tag "log --color --graph --tags --pretty=format:'${FORMAT}' --abbrev-commit"
git config --global core.editor  "nvim"

echo "Set in $(git config --global --show-origin --get core.editor | cut -f1 | sed 's/^file://'):"
git config --global --get-regexp '^(alias\.lg|alias\.lg-tag|core\.editor)$'
