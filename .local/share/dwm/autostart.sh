#!/bin/sh
# GNOME Keyring (unlocks wifi/passwords)
#eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
#export SSH_AUTH_SOCK
# Notifications (dunst)
#pgrep -x dunst > /dev/null || dunst &

feh --bg-fill .config/themes/Catppuccin/wallpapers/voyager-20.jpg &
#feh --bg-fill ~/Downloads/waves.png &
pgrep picom || picom --config ~/.config/picom/redcom2.conf &
#.local/bin/dwmblocksStarter.sh &
#sleep 2s
#pkill -x dwmblocks
/usr/local/bin/dwmblocks &
