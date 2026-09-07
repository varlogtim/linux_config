#!/usr/bin/env bash
export SWAYSOCK=$(ls /run/user/$(id -u)/sway-ipc.*.sock | head -1)
swaymsg -s "$SWAYSOCK" exit
