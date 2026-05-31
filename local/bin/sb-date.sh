#!/bin/sh

# ── Hellwal────────────────────────────────────────────────────────────────────
. "$HOME/.cache/hellwal/colors.sh"
# invert_hex() {
#    hex="${1#'#'}"
#    boost="${2:-20}"   # default boost = 20
#    r=$(( (16#${hex:0:2} ^ 255) + boost ))
#    g=$(( (16#${hex:2:2} ^ 255) + boost ))
#    b=$(( (16#${hex:4:2} ^ 255) + boost ))
#    ((r > 255)) && r=255
#    ((g > 255)) && g=255
#    ((b > 255)) && b=255
#    printf "#%02x%02x%02x\n" $r $g $b
#}
FG="$color7"
BG="$color0"
DATE="  $(date '+%a %d %b')"

#echo "^b#1e1e2e^^c#cba6f7^ $DATE^d^"
printf "^c%s^^b%s^ %s ^d^\n" "$FG" "$BG" "$DATE"
