#!/bin/sh

# Requires: iw or iwgetid
ssid=$(iwgetid -r 2>/dev/null)

if [ -z "$ssid" ]; then
  echo "   disconnected "
else
  echo " 󰤨  $ssid "
fi
