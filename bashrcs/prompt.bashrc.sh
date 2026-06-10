# Add to ~/.bashrc to set PS1 with specified colors
# Color codes: 
# 0 - black
# 1 - red
# 2 - green
# 3 - yellow
# 4 - blue
# 5 - magenta
# 6 - cyan
# 7 - white
# 8 - bright black
# 9 - bright red
# 10 - bright green
# 11 - bright yellow
# 12 - bright blue
# 13 - bright magenta
# 14 - bright cyan
# 15 - bright white

colors() {
    for i in {0..15}; do
        printf "\e[38;5;${i}m Color %2d \e[0m\n" "$i"
    done
}
PS1=''
PS1+='\[\e[38;5;11m\]('         # Opening parenthesis
# Return code of last command, green (2) if 0, bright red (9) if non-zero
PS1+='\[\e[38;5;$(( $? == 0 ? 2 : 9 ))m\]$?'  
PS1+='\[\e[38;5;11m\])'         # Closing parenthesis
PS1+='${VIRTUAL_ENV:+[\[\e[38;5;6m\]$(basename $VIRTUAL_ENV)\[\e[38;5;11m\]]}'  # virtual env prompt
PS1+='\[\e[38;5;11m\]['        # Opening square bracket
PS1+='\[\e[38;5;12m\]\u'       # Username
PS1+='\[\e[38;5;11m\]@'         # @ symbol
PS1+='\[\e[38;5;12m\]\h'       # Hostname
PS1+='\[\e[38;5;15m\] \w'      # Directory
PS1+='\[\e[38;5;11m\]]'        # Closing square bracket
PS1+='\[\e[38;5;9m\]\$'        # $
PS1+='\[\e[0m\] '              # Reset color to default


# Problem solve: easily change terminal prompt on the fly to add visual indicator 
# of the terminal containing env vars I am currently working on...
#
# TODO: in the future, I should probably add more functions for pushing env vars into a list.
# ... then making that list globally sourcable.
#
# UX:
# 1. pushps1 CoolThing
# 2. Do work on cool thing, maybe set some env vars, etc...
# 3. popps1
# ... prompt returns.
#
#

declare -a _PS1_STACK=()


pushps1() {
    _PS1_STACK+=("$PS1")
    local prefix="$*"
    PS1="${prefix}${PS1}"
}

popps1() {
    if (( ${#_PS1_STACK[@]} > 0 )); then
        PS1="${_PS1_STACK[-1]}"
        unset '_PS1_STACK[-1]'
    else
        echo "ps1pop: PS1 stack is empty" >&2
        return 1
    fi
}
