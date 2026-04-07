#!/bin/sh

# Requires: pamixer
vol=$(pamixer --get-volume)
muted=$(pamixer --get-mute)

if [ "$muted" = "true" ]; then
  echo " 󰝟 muted / "
elif [ "$vol" -ge 70 ]; then
  echo " 󰕾 $vol% / "
elif [ "$vol" -ge 30 ]; then
  echo " 󰖀 $vol% / "
else
  echo " 󰕿 $vol% / "
fi
