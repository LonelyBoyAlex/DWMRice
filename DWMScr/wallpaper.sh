#!/bin/bash

WALLDIR="$HOME/Downloads/dwmwalls"
CURRENTWALL="$HOME/DWMScr/currentwall.txt"

if [ ! -d "$WALLDIR" ]; then
  echo "Wallpaper directory not found: $WALLDIR"
  exit 1
fi

apply_theme() {
  local wall="$1"

  # Set wallpaper
  feh --bg-fill "$wall"

  # Save current wall
  echo -n "$wall" > "$CURRENTWALL"

  # Generate color palette
  hellwal -i "$wall"

  # Load colors into xrdb
  xrdb -merge "$HOME/.cache/hellwal/colors.Xresources"

  # Reload st instances live
  killall -USR1 st 2>/dev/null

  # Restart dwm to apply new colors
  xdotool key super+ctrl+shift+q

  # Reload dwmblocks
  killall dwmblocks
  sleep 0.25
  dwmblocks &
  sleep 0.25
  kill -USR1 $(pidof dwmblocks) 2>/dev/null

  # Update lockscreen in background (slow operation, do last)
  betterlockscreen -u "$wall" --fx blur &
}

if [ "$1" = "choose" ]; then
  chosen=$(ls "$WALLDIR" | rofi -i -dmenu \
    -config ~/DWMScr/config.rasi \
    -p "  Wallpaper ")
  [ -z "$chosen" ] && exit 0
  apply_theme "$WALLDIR/$chosen"
else
  walls=("$WALLDIR"/*)
  count=${#walls[@]}
    if [ "$count" -eq 0 ]; then
      echo "No wallpapers found in $WALLDIR"
      exit 1
    fi
    random="${walls[RANDOM % count]}"
    apply_theme "$random"
fi
