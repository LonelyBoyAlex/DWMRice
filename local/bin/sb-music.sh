#!/bin/sh
# sb-music.sh — music block for dwmblocks
# Dependencies: playerctl

# ── Hellwal────────────────────────────────────────────────────────────────────
. "$HOME/.cache/hellwal/colors.sh"

# ── Config ────────────────────────────────────────────────────────────────────
ICON_PLAY="  "
ICON_PAUSE="󰏤 "
ICON_IDLE="󰽯 "
MAX_LEN=60
SEPARATOR="/"
FG="$color2"
BG="$color14"
# ─────────────────────────────────────────────────────────────────────────────

case "$BLOCK_BUTTON" in
    1) playerctl play-pause ;;
    3) playerctl next ;;
    6) playerctl previous ;;
esac

command -v playerctl >/dev/null 2>&1 || {
    printf "^c%s^^b%s^ %sNothing Playing ^d^\n" "$FG" "$BG" "$ICON_IDLE"
    exit 0
}

STATUS=$(playerctl status 2>/dev/null)

if [ -z "$STATUS" ] || [ "$STATUS" = "Stopped" ]; then
    printf "^c%s^^b%s^ %sNothing Playing ^d^\n" "$FG" "$BG" "$ICON_IDLE"
    exit 0
fi

if [ "$STATUS" = "Playing" ]; then
    ICON="$ICON_PLAY"
else
    ICON="$ICON_PAUSE"
fi

ARTIST=$(playerctl metadata artist 2>/dev/null)
TITLE=$(playerctl metadata title 2>/dev/null)

if [ -n "$ARTIST" ] && [ -n "$TITLE" ]; then
    LABEL="$TITLE > $ARTIST "
elif [ -n "$TITLE" ]; then
    LABEL="$TITLE "
else
    LABEL="Unknown"
fi

if [ "${#LABEL}" -gt "$MAX_LEN" ]; then
    LABEL="$(printf '%s' "$LABEL" | cut -c1-$((MAX_LEN - 1)))…"
fi

POSITION=$(playerctl metadata position 2>/dev/null | cut -d. -f1)
LENGTH=$(playerctl metadata mpris:length 2>/dev/null)

if [ -n "$POSITION" ] && [ -n "$LENGTH" ] && [ "$LENGTH" -gt 0 ] 2>/dev/null; then
    TOTAL_SEC=$(( LENGTH / 1000000 ))
    CUR_M=$(( POSITION / 60 ))
    CUR_S=$(( POSITION % 60 ))
    TOT_M=$(( TOTAL_SEC / 60 ))
    TOT_S=$(( TOTAL_SEC % 60 ))
    TIME=$(printf "%d:%02d/%d:%02d" "$CUR_M" "$CUR_S" "$TOT_M" "$TOT_S")
    printf "^c%s^^b%s^ %s%s%s%s ^d^\n" "$FG" "$BG" "$ICON" "$LABEL" "$SEPARATOR" "$TIME"
else
    printf "^c%s^^b%s^ %s%s ^d^\n" "$FG" "$BG" "$ICON" "$LABEL"
fi
