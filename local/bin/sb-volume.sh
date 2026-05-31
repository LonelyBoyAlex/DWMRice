#!/bin/sh

# ── Hellwal────────────────────────────────────────────────────────────────────
. "$HOME/.cache/hellwal/colors.sh"
FG="$color8"

# Invert color6 manually
invert_hex() {
    hex="${1#'#'}"  # strip #
    r=$((16#${hex:0:2} ^ 255))
    g=$((16#${hex:2:2} ^ 255))
    b=$((16#${hex:4:2} ^ 255))
    printf "#%02x%02x%02x" $r $g $b
}
BG=$color6

# Requires: pamixer
sleep 0.25s
vol=$(pamixer --get-volume)
muted=$(pamixer --get-mute)

 build_bar() {
    local vol=$1
    local filled=$(( vol / 20 ))
    local empty=$(( 5 - filled ))
    local bar=""
    for i in $(seq 1 $filled); do bar="${bar}󰹞"; done
    for i in $(seq 1 $empty); do bar="${bar}-"; done
    printf "%s" "$bar"
}

if [ "$muted" = "true" ]; then
    printf "^c%s^^b%s^ 󰝟 --- muted ^d^\n" "$FG" "$BG"
else
    bar=$(build_bar "$vol")
    if [ "$vol" -ge 70 ]; then
        icon="󰕾"
    elif [ "$vol" -ge 30 ]; then
        icon="󰖀"
    else
        icon="󰕿"
    fi
    printf "^c%s^^b%s^ %s %s %s%% ^d^\n" "$FG" "$BG" "$icon" "$bar" "$vol"
fi
#
#
#vol=$(pamixer --get-volume)
#muted=$(pamixer --get-mute)
#
#if [ "$muted" = "true" ]; then
#    printf "^c%s^^b%s^ 󰝟 muted ^d^\n" "$FG" "$BG"
#elif [ "$vol" -ge 70 ]; then
#    printf "^c%s^^b%s^ 󰕾 %s%% ^d^\n" "$FG" "$BG" "$vol"
#elif [ "$vol" -ge 30 ]; then
#    printf "^c%s^^b%s^ 󰖀 %s%% ^d^\n" "$FG" "$BG" "$vol"
#else
#    printf "^c%s^^b%s^ 󰕿 %s%% ^d^\n" "$FG" "$BG" "$vol"
#fi
#

