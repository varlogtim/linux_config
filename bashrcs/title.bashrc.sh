# Per-terminal "workstream" labels via Sway title_format.
#
# Problem:
#   I use Sway in stacked mode and read the Alacritty title bars as a list of my
#   current workstreams. But the SHELL can't own the title: while a foreground
#   app (opencode, vim, k9s...) runs, PROMPT_COMMAND never fires, so any OSC
#   title the shell emits is immediately overwritten by the app. The app wins
#   for as long as it runs.
#
# Solution:
#   Let the window manager own a persistent prefix. Sway's `title_format`
#   composites AFTER the app writes its title, and substitutes `%title` with
#   whatever the app set. So:
#
#       title_format "myworkstream » %title"
#
#   keeps my label pinned while the app's own title flows into `%title`,
#   appearing *after* my label. This is the whole point: my label always wins,
#   the app title is appended.
#
# UX (mirrors pushps1/popps1):
#   wt <label>     set this window's label (replaces the stack with one entry)
#   wt             no arg -> clear the label (back to plain "%title")
#   pusht <label>  push a nested sub-label:  "ws » sub » %title"
#   popt           pop one nesting level
#
# The stack lives in this bash process (like _PS1_STACK). Every mutation
# re-renders Sway's title_format for the focused container, so it survives any
# app that later rewrites the title.

# Separator between label segments and before %title.
: "${_WT_SEP:= » }"

declare -a _WT_STACK=()

# Escape a string for safe embedding inside the double-quoted swaymsg argument.
_wt_escape() {
    local s="$1"
    s="${s//\\/\\\\}"   # backslash -> \\
    s="${s//\"/\\\"}"   # "        -> \"
    printf '%s' "$s"
}

# Render the current stack into the focused container's Sway title_format.
_wt_render() {
    if [ -z "$SWAYSOCK" ]; then
        echo "wt: not running under Sway (no \$SWAYSOCK); title unchanged" >&2
        return 1
    fi

    local fmt
    if (( ${#_WT_STACK[@]} == 0 )); then
        fmt='%title'
    else
        local joined="" seg
        for seg in "${_WT_STACK[@]}"; do
            if [ -z "$joined" ]; then
                joined="$seg"
            else
                joined="${joined}${_WT_SEP}${seg}"
            fi
        done
        fmt="$(_wt_escape "${joined}${_WT_SEP}")%title"
    fi

    swaymsg "[con_id=__focused__] title_format \"${fmt}\"" >/dev/null
}

# Set (replace) this window's label. No arg clears it.
wt() {
    if (( $# == 0 )); then
        _WT_STACK=()
    else
        _WT_STACK=("$*")
    fi
    _wt_render
}

# Push a nested sub-label onto the stack.
pusht() {
    if (( $# == 0 )); then
        echo "pusht: need a label" >&2
        return 1
    fi
    _WT_STACK+=("$*")
    _wt_render
}

# Pop one nesting level off the stack.
popt() {
    if (( ${#_WT_STACK[@]} == 0 )); then
        echo "popt: title stack is empty" >&2
        return 1
    fi
    unset '_WT_STACK[-1]'
    _WT_STACK=("${_WT_STACK[@]}")   # reindex
    _wt_render
}
