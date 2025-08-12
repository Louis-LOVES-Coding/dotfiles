#!/bin/bash

STATE_FILE="$HOME/.cache/hyprsunset_mode"

# Values for ON state
WARM_TEMP=3800
WARM_GAMMA=90

# Kill any running instance
pkill hyprsunset
:
if [[ -f "$STATE_FILE" && $(cat "$STATE_FILE") == "on" ]]; then
    # Turn OFF (use identity/no color change)
    hyprsunset --identity &
    echo "off" > "$STATE_FILE"
    notify-send "Hyprsunset: OFF"
else
    # Turn ON (apply warm color)
    hyprsunset --temperature "$WARM_TEMP" --gamma "$WARM_GAMMA" &
    echo "on" > "$STATE_FILE"
    notify-send "Hyprsunset: ON ($WARM_TEMP K)"
fi

