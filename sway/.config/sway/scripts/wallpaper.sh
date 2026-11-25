#!/usr/bin/env sh
# Single wallpaper: ~/Pictures/wallpaper.{jpg,jpeg,png,webp,jxl}, first one found.
# Without one, sway keeps Fedora's default from `output * bg` in the config.
for ext in jpg jpeg png webp jxl; do
    img="$HOME/Pictures/wallpaper.$ext"
    if [ -f "$img" ]; then
        exec swaymsg output '*' bg "$img" fill >/dev/null
    fi
done
