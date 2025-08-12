#!/bin/bash

# Advanced System Tray Menu for Hyprland
# Provides quick access to system functions

show_menu() {
    rofi -show -modi "system:~/bin/rofi-system-menu" -show system -theme ~/.config/rofi/themes/KooL_style-2-Dark.rasi
}

# System functions
case "$1" in
    "power")
        wlogout --protocol layer-shell
        ;;
    "settings")
        rofi -show drun -modi drun -theme ~/.config/rofi/themes/KooL_style-2-Dark.rasi
        ;;
    "network")
        nm-connection-editor &
        ;;
    "bluetooth")
        blueman-manager &
        ;;
    "volume")
        pavucontrol &
        ;;
    "brightness")
        brightnessctl set 50%
        ;;
    "screenshot")
        ~/.config/hypr/scripts/ScreenShot.sh --now
        ;;
    "lock")
        ~/.config/hypr/scripts/LockScreen.sh
        ;;
    "suspend")
        systemctl suspend
        ;;
    "reboot")
        systemctl reboot
        ;;
    "shutdown")
        systemctl poweroff
        ;;
    *)
        echo -e "Power\nSettings\nNetwork\nBluetooth\nVolume\nBrightness\nScreenshot\nLock\nSuspend\nReboot\nShutdown" | rofi -dmenu -p "System" -theme ~/.config/rofi/themes/KooL_style-2-Dark.rasi
        ;;
esac 