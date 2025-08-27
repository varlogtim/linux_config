# Utils
alias jiggle='while true; do DISPLAY=:0 xdotool mousemove $(( 1 + $RANDOM % 1920 )) $(( 1 + $RANDOM % 1080 )); sleep 1; done'
alias wakeup='export DISPLAY=:0; xrandr --output DP-0 --mode 3840x2160'
