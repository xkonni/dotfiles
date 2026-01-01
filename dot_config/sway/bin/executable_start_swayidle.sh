#!/bin/bash

TERM_CMD="foot -T float"
LOCK_CMD="$HOME/.config/sway/bin/sway_lock"
PWR_CMD="$HOME/.config/sway/bin/sway_power"

### Idle configuration
#    9 min    warning
#   10 min    screen off
#   15 min    lock
#   60 min    suspend on battery
#  120 min    suspend
pkill -x swayidle
swayidle -w \
    timeout 540 "$TERM_CMD bash -c 'dunstify -r 123 -u critical -t 300 display\ will\ turn\ off\ soon'" \
    resume "$LOCK_CMD on" \
    timeout 600 "$LOCK_CMD off" \
    # timeout 900 "$LOCK_CMD lockonly" \
    # timeout 3600 "$PWR_CMD suspend-battery" \
    # timeout 7200 "$PWR_CMD suspend" \
    # before-sleep "$LOCK_CMD lock"
