#!/bin/sh

# ── Hellwal────────────────────────────────────────────────────────────────────
. "$HOME/.cache/hellwal/colors.sh"

# Invert color6 manually
# invert_hex() {
#    hex="${1#'#'}"  # strip #
#    r=$((16#${hex:0:2} ^ 255))
#    g=$((16#${hex:2:2} ^ 255))
#    b=$((16#${hex:4:2} ^ 255))
#    printf "#%02x%02x%02x" $r $g $b
#}
invert_hex() {
    hex="${1#'#'}"
    boost="${2:-20}"   # default boost = 20

    r=$(( (16#${hex:0:2} ^ 255) + boost ))
    g=$(( (16#${hex:2:2} ^ 255) + boost ))
    b=$(( (16#${hex:4:2} ^ 255) + boost ))

    ((r > 255)) && r=255
    ((g > 255)) && g=255
    ((b > 255)) && b=255

    printf "#%02x%02x%02x\n" $r $g $b
}

FG=$(invert_hex "$color14" 0)
BG=$(invert_hex "$color6" 140)

TIME="  $(date '+%I:%M %p')"

#echo "^c#1e1e2e^^b#cba6f7^ $TIME ^d^"
printf "^c%s^^b%s^ %s ^d^\n" "$FG" "$BG" "$TIME"
