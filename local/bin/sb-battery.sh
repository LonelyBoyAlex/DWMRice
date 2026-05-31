#!/bin/sh

# ── Hellwal────────────────────────────────────────────────────────────────────
. "$HOME/.cache/hellwal/colors.sh"
FG="$color15"
BG="$color1"

battery=/sys/class/power_supply/BAT0
[ ! -d "$battery" ] && battery=/sys/class/power_supply/BAT1
[ ! -d "$battery" ] && exit 0

capacity=$(cat "$battery/capacity")
status=$(cat "$battery/status")

if [ "$status" = "Charging" ]; then
  icon="󱐌"
elif [ "$capacity" -ge 90 ]; then
  icon="󰁹"
elif [ "$capacity" -ge 70 ]; then
  icon="󰂀"
elif [ "$capacity" -ge 50 ]; then
  icon="󰁾"
elif [ "$capacity" -ge 30 ]; then
  icon="󰁼"
elif [ "$capacity" -ge 10 ]; then
  icon="󰁺"
else
  icon="󰂃"
fi

#echo "$icon $capacity% "
printf "^c%s^^b%s^ %s%s%% ^d^\n" "$FG" "$BG" "$icon " "$capacity"
