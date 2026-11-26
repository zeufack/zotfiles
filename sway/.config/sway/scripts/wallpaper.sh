#!/usr/bin/env sh
# Wallpaper, first one found:
#   1. ~/Pictures/wallpaper.{jpg,jpeg,png,webp,jxl}        (your own, wins over themes)
#   2. ~/.config/themes/current/wallpaper.{...}            (shipped with the theme)
# Without either, sway keeps Fedora's default from `output * bg` in the config.
for base in "$HOME/Pictures/wallpaper" "$HOME/.config/themes/current/wallpaper"; do
    for ext in jpg jpeg png webp jxl; do
        if [ -f "$base.$ext" ]; then
            exec swaymsg output '*' bg "$base.$ext" fill >/dev/null
        fi
    done
done
