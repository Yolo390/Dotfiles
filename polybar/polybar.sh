#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Launch Polybar
polybar --config=~/.config/polybar/config.ini flo-slv 2>&1 | tee -a /tmp/polybar.log & disown

echo 'Polybar launched...'
