#!/bin/bash

WALLDIR="$HOME/Downloads/dwmwalls"

if [ ! -d "$WALLDIR" ]; then
    echo "Wallpaper directory not found: $WALLDIR"
    exit 1
fi

if [ "$1" = "choose" ]; then
    chosen=$(ls "$WALLDIR" | dmenu -i -l 6 -fn "Iosevka Nerd Font:size=16" -nb "#1e1e2e" -nf "#cdd6f4" -sb "#cba6f7" -sf "#1e1e2e" -p " Wallpaper:")
    [ -z "$chosen" ] && exit 0
    feh --bg-fill "$WALLDIR/$chosen"
else
    walls=("$WALLDIR"/*)
    count=${#walls[@]}
    if [ "$count" -eq 0 ]; then
        echo "No wallpapers found in $WALLDIR"
        exit 1
    fi
    random="${walls[RANDOM % count]}"
    feh --bg-fill "$random"
fi
