#!/usr/bin/env sh
# Waybar JSON for the notification button: history count + do-not-disturb state.
count=$(dunstctl count history 2>/dev/null || echo 0)
if [ "$(dunstctl is-paused 2>/dev/null)" = "true" ]; then dnd="dnd-"; mode="Do not disturb"; else dnd=""; mode="Notifications on"; fi
if [ "$count" -gt 0 ]; then state="${dnd}notification"; else state="${dnd}none"; fi
printf '{"alt":"%s","class":"%s","tooltip":"%s · %s in history\\nclick: show last · middle: clear · right: toggle DND"}\n' \
    "$state" "$state" "$mode" "$count"
