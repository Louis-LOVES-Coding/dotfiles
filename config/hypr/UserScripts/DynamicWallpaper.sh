#!/bin/bash

# Dynamic Wallpaper Script for Hyprland
# Changes wallpapers automatically with smooth transitions

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
TRANSITION_TIME=1.0
CHANGE_INTERVAL=300  # 5 minutes

# Create wallpaper directory if it doesn't exist
mkdir -p "$WALLPAPER_DIR"

# Function to get random wallpaper
get_random_wallpaper() {
    find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1
}

# Function to change wallpaper with transition
change_wallpaper() {
    local wallpaper="$1"
    if [[ -f "$wallpaper" ]]; then
        echo "Changing wallpaper to: $(basename "$wallpaper")"
        swww img "$wallpaper" --transition-type wipe --transition-duration "$TRANSITION_TIME"
    fi
}

# Function to set wallpaper based on time of day
set_time_based_wallpaper() {
    local hour=$(date +%H)
    local wallpaper=""
    
    case $hour in
        06|07|08|09|10|11)  # Morning (6-11)
            wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*morning*" -o -iname "*sunrise*" -o -iname "*dawn*" \) | shuf -n 1)
            ;;
        12|13|14|15|16|17)  # Afternoon (12-17)
            wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*day*" -o -iname "*sunny*" -o -iname "*bright*" \) | shuf -n 1)
            ;;
        18|19|20|21)        # Evening (18-21)
            wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*evening*" -o -iname "*sunset*" -o -iname "*dusk*" \) | shuf -n 1)
            ;;
        *)                  # Night (22-5)
            wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*night*" -o -iname "*dark*" -o -iname "*moon*" \) | shuf -n 1)
            ;;
    esac
    
    # Fallback to random wallpaper if no time-based wallpaper found
    if [[ -z "$wallpaper" ]]; then
        wallpaper=$(get_random_wallpaper)
    fi
    
    change_wallpaper "$wallpaper"
}

# Main script logic
case "$1" in
    "random")
        change_wallpaper "$(get_random_wallpaper)"
        ;;
    "time")
        set_time_based_wallpaper
        ;;
    "daemon")
        echo "Starting dynamic wallpaper daemon..."
        while true; do
            set_time_based_wallpaper
            sleep "$CHANGE_INTERVAL"
        done
        ;;
    "init")
        # Initialize swww daemon if not running
        if ! pgrep -x "swww-daemon" > /dev/null; then
            swww-daemon --format xrgb &
            sleep 1
        fi
        set_time_based_wallpaper
        ;;
    *)
        echo "Usage: $0 {random|time|daemon|init}"
        echo "  random  - Set random wallpaper"
        echo "  time    - Set time-based wallpaper"
        echo "  daemon  - Start daemon for automatic changes"
        echo "  init    - Initialize and set wallpaper"
        exit 1
        ;;
esac 