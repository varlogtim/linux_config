#!/bin/bash
mv -v ${HOSTNAME}.pacman.installed ${HOSTNAME}.pacman.installed.old
/usr/bin/pacman -Qe > ${HOSTNAME}.pacman.installed

# TODO: Maybe show a diff? Backout if failed?
