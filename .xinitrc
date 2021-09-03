#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
startup_script=$HOME/.startup_script.sh

# merge in defaults and keymaps
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -f "$startup_scripts" ]; then
    source "$startup_script"
    echo "Foo" > /tmp/test.startup
fi

# exec copyq
exec awesome
