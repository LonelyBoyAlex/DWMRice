#!/bin/sh

prefix="/usr"
exec_prefix="${prefix}"
xrdb="xrdb"
xinitdir="/etc/X11/xinit"
xclock="xclock"
xterm="xterm"
twm="twm"
xmodmap="xmodmap"

userresources="$HOME/.Xresources"
usermodmap="$HOME/.Xmodmap"
sysresources="$xinitdir/.Xresources"
sysmodmap="$xinitdir/.Xmodmap"

# merge in defaults and keymaps

if [ -f "$sysresources" ]; then
    if [ -x /usr/bin/cpp ] ; then
        "$xrdb" -merge "$sysresources"
    else
        "$xrdb" -nocpp -merge "$sysresources"
    fi
fi

if [ -f "$sysmodmap" ]; then
    "$xmodmap" "$sysmodmap"
fi

if [ -f "$userresources" ]; then
    if [ -x /usr/bin/cpp ] ; then
        "$xrdb" -merge "$userresources"
    else
        "$xrdb" -nocpp -merge "$userresources"
    fi
fi

if [ -f "$usermodmap" ]; then
    "$xmodmap" "$usermodmap"
fi

# start some nice programs

if [ -d "$xinitdir"/xinitrc.d ] ; then
	for f in "$xinitdir/xinitrc.d"/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

#"$twm" &
#"$xclock" -geometry 50x50-1+1 &
#"$xterm" -geometry 80x50+494+51 &
#"$xterm" -geometry 80x20+494-0 &
#exec "$xterm" -geometry 80x66+0+0 -name login

export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#$HOME/DWMScr/wallpaper.sh &
#picom --config ~/.config/picom/redcomF2.conf &
picom --config ~/.config/picom/bread.conf &
udiskie --tray &
blueman-applet &
dwmblocks &
dunst &
# Restore wallpaper and colors on login
if [ -f "$HOME/DWMScr/currentwall.txt" ]; then
    wall=$(cat "$HOME/DWMScr/currentwall.txt" | tr -d '[:space:]')
    feh --bg-fill "$wall"
    hellwal -i "$wall"
    xrdb -merge "$HOME/.cache/hellwal/colors.Xresources"
fi
exec dwm
