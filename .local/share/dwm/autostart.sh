#!/bin/bash

# GNOME Keyring (unlocks wifi/passwords)
#eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
#export SSH_AUTH_SOCK
# Notifications (dunst)
#pgrep -x dunst > /dev/null || dunst &
#feh --bg-fill ~/Downloads/waves.png &
#~/.local/bin/dwmblocksStarter.sh &
#sleep 2s
#pkill -x dwmblocks
#exec >> ~/.local/share/dwm/autostart.log 2>&1
#set -x
#feh --bg-fill .config/themes/Catppuccin/wallpapers/voyager-21.jpg &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
$HOME/DWMScr/wallpaper.sh &
pgrep picom || picom --config ~/.config/picom/redcomF2.conf &
DWMScr/blocks.sh &
