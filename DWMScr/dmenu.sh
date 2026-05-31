#!/usr/bin/env bash
# dmenu.sh — unified dmenu script
# Usage: dmenu.sh launcher | dmenu.sh powermenu | dmenu.sh screenshot
# ── Hellwal colors ────────────────────────────────────────────────────────────
. "$HOME/.cache/hellwal/colors.sh"
# ── Appearance ────────────────────────────────────────────────────────────────
DMENU_FONT="Iosevka Nerd Font:size=15"
DMENU_BG="$color3"
DMENU_FG="$foreground"
DMENU_SEL_BG="$color15"
DMENU_SEL_FG="$color0"
DMENU_ALPHA="120"
dmenu_args=(
    -fn "$DMENU_FONT"
    -nb "$DMENU_BG"
    -nf "$DMENU_FG"
    -sb "$DMENU_SEL_BG"
    -sf "$DMENU_SEL_FG"
    -o  "$DMENU_ALPHA"
)
# ── Lock command ──────────────────────────────────────────────────────────────
lock_cmd() {
    betterlockscreen -l blur -q --blur 1.0
}
# ── Logout command ────────────────────────────────────────────────────────────
logout_cmd() {
    pkill dwm
}
# ── Modes ─────────────────────────────────────────────────────────────────────
case "$1" in
    launcher)
        j4-dmenu-desktop --dmenu="dmenu -fn '$DMENU_FONT' -nb '$DMENU_BG' -nf '$DMENU_FG' -sb '$DMENU_SEL_BG' -sf '$DMENU_SEL_FG' -o '$DMENU_ALPHA' -p ' Apps:'"
        ;;
    powermenu)
        ENTRIES="󰐥  Poweroff \n󰌾  Lock \n󰜉  Reboot \n󰍃  Logout "
        CHOICE=$(printf "%b" "$ENTRIES" | dmenu "${dmenu_args[@]}" -l 4 -c -fn "Iosevka Nerd Font:size=20" -p "  Power:")
        case "$CHOICE" in
            *Lock*)     lock_cmd ;;
            *Logout*)   logout_cmd ;;
            *Reboot*)   systemctl reboot ;;
            *Poweroff*) systemctl poweroff ;;
            *)          exit 0 ;;
        esac
        ;;
    screenshot)
        SAVEDIR="$HOME/Pictures/screenshots"
        mkdir -p "$SAVEDIR"
        FILENAME="$SAVEDIR/$(date +%Y-%m-%d_%H-%M-%S).png"
        CHOICE=$(printf "Fullscreen\nRegion\nWindow\nFullscreen (5s delay)\nRegion (copy to clipboard)" \
            | dmenu "${dmenu_args[@]}" -p "󰄀 Screenshot:")
        case "$CHOICE" in
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
        ;;
    *)
        echo "Usage: $0 launcher | powermenu | screenshot"
        exit 1
        ;;
esac
