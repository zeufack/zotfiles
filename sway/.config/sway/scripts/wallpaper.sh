#!/usr/bin/env sh
# Set a random wallpaper from ~/Pictures/wallpapers; keep Fedora's default if empty.
dir="${WALLPAPER_DIR:-$HOME/Pictures/wallpapers}"
[ -d "$dir" ] || exit 0
img=$(find "$dir" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.jxl' \) | shuf -n 1)
[ -n "$img" ] && swaymsg output '*' bg "$img" fill >/dev/null
