#!/usr/bin/env bash
# powermenu.sh — dmenu power menu
# Deps: dmenu, systemctl (for poweroff/reboot), plus one of:
#   - loginctl  (lock / logout via logind — works with most DEs/WMs)
#   - i3lock / swaylock / slock  (fallback lock programs)
# Customise the DMENU_* variables below to match your bar colours/font.

# ── Appearance ────────────────────────────────────────────────────────────────
DMENU_FONT="Iosevka Nerd Font:size=16"
DMENU_BG="#1e1e2e"          # Mocha base
DMENU_FG="#cdd6f4"          # Mocha text
DMENU_SEL_BG="#cba6f7"      # Mocha mauve
DMENU_SEL_FG="#1e1e2e"      # Mocha base (text on highlight)
DMENU_PROMPT="  Power:"     # prompt text (use an icon if your font supports it)
DMENU_LINES=0               # 0 = horizontal bar; set >0 for vertical list

# ── Lock command ──────────────────────────────────────────────────────────────
# Adjust to your locker of choice: i3lock, swaylock, slock, xscreensaver-command -lock …
lock_cmd() {
    if command -v loginctl &>/dev/null; then
        loginctl lock-session
    elif command -v i3lock &>/dev/null; then
        i3lock -c 1e1e2e
    elif command -v swaylock &>/dev/null; then
        swaylock
    elif command -v slock &>/dev/null; then
        slock
    else
        notify-send "powermenu" "No lock program found." 2>/dev/null
    fi
}

# ── Logout command ────────────────────────────────────────────────────────────
logout_cmd() {
    pkill dwm
}

# ── Menu entries ──────────────────────────────────────────────────────────────
ENTRIES="󰐥  Poweroff\n󰌾  Lock\n󰜉  Reboot\n󰍃  Logout"
# Plain text fallback (no Nerd Font icons):
# ENTRIES="Lock\nLogout\nReboot\nPoweroff"

# ── Build dmenu command ───────────────────────────────────────────────────────
dmenu_args=(
    -fn "$DMENU_FONT"
    -nb "$DMENU_BG"
    -nf "$DMENU_FG"
    -sb "$DMENU_SEL_BG"
    -sf "$DMENU_SEL_FG"
    -p  "$DMENU_PROMPT"
    -i
)
[[ $DMENU_LINES -gt 0 ]] && dmenu_args+=(-l "$DMENU_LINES")

# ── Show menu and act ─────────────────────────────────────────────────────────
CHOICE=$(printf "%b" "$ENTRIES" | dmenu "${dmenu_args[@]}")

case "$CHOICE" in
    *Lock*)     lock_cmd ;;
    *Logout*)   logout_cmd ;;
    *Reboot*)   systemctl reboot ;;
    *Poweroff*) systemctl poweroff ;;
    *)          exit 0 ;;   # dismissed / no selection
esac
