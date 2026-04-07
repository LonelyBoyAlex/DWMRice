#!/bin/bash

choice=$(printf "Fullscreen\nRegion\nWindow\nFullscreen (5s delay)\nRegion (copy to clipboard)" | dmenu -i -fn "Iosevka Nerd Font:size=16" -nb "#1e1e2e" -nf "#cdd6f4" -sb "#cba6f7" -sf "#1e1e2e" -p "󰄀 Screenshot:")

SAVEDIR="$HOME/Pictures/screenshots"
mkdir -p "$SAVEDIR"
FILENAME="$SAVEDIR/$(date +%Y-%m-%d_%H-%M-%S).png"

case "$choice" in
    "Fullscreen")           scrot "$FILENAME" ;;
    "Region")               scrot -s "$FILENAME" ;;
    "Window")               scrot -u "$FILENAME" ;;
    "Fullscreen (5s delay)")scrot -d 5 "$FILENAME" ;;
    "Region (copy to clipboard)")
                            scrot -s /tmp/scrot_tmp.png
                            xclip -selection clipboard -t image/png -i /tmp/scrot_tmp.png
                            rm /tmp/scrot_tmp.png
                            notify-send "Screenshot" "Copied to clipboard"
                            exit 0 ;;
    *) exit 0 ;;
esac

notify-send "Screenshot" "Saved to $FILENAME"
