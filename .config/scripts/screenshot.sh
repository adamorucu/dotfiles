#!/usr/bin/sh
out=$HOME/Pictures/screens/"$(date +%s_%d-%m-%Y-%H:%M).png"
scrot "$out"
notify-send "Scrot" "Screenshot taken"
