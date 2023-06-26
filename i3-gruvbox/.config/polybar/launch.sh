#!/usr/bin/env bash

polybar-msg cmd quit
# killall -q polybar

echo "---" | tee -a /tmp.polybar.log
polybar mainbar 2>&1 | tee -a /tmp/polybar.log & disown

echo "Bar launched..."
