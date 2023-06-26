#! /usr/bin/env bash

function launch_player() {
  # kitty @ new-window --new-tab --tab-title music --title cover sh
  kitty @ launch --title Cover --keep-focus
  # kitty @ send-text 'export PS1="" \r'
  kitty @ send-text --match 'title:^Cover' 'export PS1="" \r'
  change_cover
  kitty @ new-window --title ncmpcpp ncmpcpp
  kitty @ resize-window --increment 93
}

function change_cover() {
  kitty @ send-text \
    --match 'title:^Cover' \
    'clear && kitty icat --transfer-mode=stream /tmp/cover.png \r'
}

function extract_cover() {
  music_dir="$HOME/Music"
  temp_song="/tmp/current-song"

  cp "$music_dir/$(mpc --format %file% current)" "$temp_song"

  ffmpeg \
    -hide_banner \
    -loglevel 0 \
    -y \
    -i "$temp_song" \
    -vf scale=400:-1 \
    "/tmp/cover.png" > /dev/null 2>&1

  rm "$temp_song"
}

if [[ $1 == "extract" ]]; then
  extract_cover
  change_cover
else
  launch_player
fi
