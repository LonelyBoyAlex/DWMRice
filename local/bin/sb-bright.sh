#!/bin/sh
# ── Hellwal────────────────────────────────────────────────────────────────────
. "$HOME/.cache/hellwal/colors.sh"
FG=$foreground
BG=$background

# Requires: brightnessctl
sleep 0.25s

brightness=$(brightnessctl get)
max=$(brightnessctl max)
percent=$(( brightness * 100 / max ))

build_bar() {
    local val=$1
    local filled=$(( val / 20 ))
    local empty=$(( 5 - filled ))
    local bar=""
    for i in $(seq 1 $filled); do bar="${bar}󰹞"; done
    for i in $(seq 1 $empty); do bar="${bar}-"; done
    printf "%s" "$bar"
}

bar=$(build_bar "$percent")

if [ "$percent" -ge 70 ]; then
    icon="󰃠 "
elif [ "$percent" -ge 40 ]; then
    icon="󰃟 "
elif [ "$percent" -ge 10 ]; then
    icon="󰃞 "
else
    icon="󰃝 "
fi

printf "^c%s^^b%s^ %s %s %s%% ^d^\n" "$FG" "$BG" "$icon" "$bar" "$percent"
