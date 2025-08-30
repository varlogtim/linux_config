#!/usr/bin/env bash
export XDG_CURRENT_DESKTOP=sway
export WLR_NO_HARDWARE_CURSORS=1
export WLR_RENDERER=vulkan
export LIBVA_DRIVER_NAME=nvidia
export EGL_PLATFORM=wayland

sway --unsupported-gpu
