#!/bin/sh

music_dir="$HOME/Music"
previewdir="$XDG_CONFIG_HOME/ncmpcpp/previews"
filename="$(mpc --format "$music_dir"/%file% current)"
previewname="$previewdir/$(mpc --format %album% current | base64).png"

[ -e "$previewname" ] || ffmpeg -y -i "$filename" -an -vf scale=128:128 "$previewname" > /dev/null 2>&1

# notify-send -r 27072 "$(mpc --format '%title% \nby %artist% - %album%' current)" -i "$previewname"

notify-send -r 27072 "$(mpc --format '%artist% \n%title% \[%album%\]' current)" -i "$previewname"
