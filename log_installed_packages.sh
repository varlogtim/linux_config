#!/bin/bash
mv -v pacman.installed pacman.installed.old
/usr/bin/pacman -Qe > pacman.installed

# TODO: Maybe show a diff? Backout if failed?
