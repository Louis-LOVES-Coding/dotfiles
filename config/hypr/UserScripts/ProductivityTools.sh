#!/bin/bash

# Productivity Tools for Hyprland
# Enhanced clipboard, launcher, and screen recording

case "$1" in
    "clipboard")
        # Enhanced clipboard management
        case "$2" in
            "copy")
                wl-copy < /dev/stdin
                notify-send "Clipboard" "Text copied to clipboard" -u low
                ;;
            "paste")
                wl-paste
                ;;
            "history")
                # Show clipboard history with rofi
                cliphist list | rofi -dmenu -p "Clipboard History" | cliphist decode | wl-copy
                ;;
            "clear")
                cliphist wipe
                notify-send "Clipboard" "History cleared" -u low
                ;;
            *)
                echo "Usage: $0 clipboard {copy|paste|history|clear}"
                ;;
        esac
        ;;
    "launcher")
        # Enhanced application launcher
        rofi -show drun -theme ~/.config/rofi/themes/default.rasi
        ;;
    "screenshot")
        # Enhanced screenshot tool
        case "$2" in
            "full")
                grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png
                notify-send "Screenshot" "Full screenshot saved" -u low
                ;;
            "area")
                grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png
                notify-send "Screenshot" "Area screenshot saved" -u low
                ;;
            "window")
                grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')" ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png
                notify-send "Screenshot" "Window screenshot saved" -u low
                ;;
            *)
                echo "Usage: $0 screenshot {full|area|window}"
                ;;
        esac
        ;;
    "record")
        # Screen recording with wf-recorder
        case "$2" in
            "start")
                wf-recorder -g "$(slurp)" -f ~/Videos/$(date +%Y%m%d_%H%M%S).mp4
                ;;
            "stop")
                pkill -f wf-recorder
                notify-send "Recording" "Screen recording stopped" -u low
                ;;
            *)
                echo "Usage: $0 record {start|stop}"
                ;;
        esac
        ;;
    *)
        echo "Usage: $0 {clipboard|launcher|screenshot|record}"
        echo "  clipboard copy    - Copy text to clipboard"
        echo "  clipboard paste   - Paste from clipboard"
        echo "  clipboard history - Show clipboard history"
        echo "  clipboard clear   - Clear clipboard history"
        echo "  launcher         - Open application launcher"
        echo "  screenshot full  - Take full screenshot"
        echo "  screenshot area  - Take area screenshot"
        echo "  screenshot window- Take window screenshot"
        echo "  record start     - Start screen recording"
        echo "  record stop      - Stop screen recording"
        ;;
esac 