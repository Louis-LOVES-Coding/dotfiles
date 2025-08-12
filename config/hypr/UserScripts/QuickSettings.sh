#!/bin/bash

# Quick Settings Panel for Hyprland
# Provides easy access to common system settings

show_menu() {
    local options=(
        "🔊 Volume Control"
        "💡 Brightness"
        "🌐 Network"
        "📶 Bluetooth"
        "🎨 Theme"
        "🎮 Game Mode"
        "📱 Performance"
        "🔒 Lock Screen"
        "🖼️ Screenshot"
        "⚙️ System Settings"
        "🔄 Refresh"
        "🌙 Night Light"
        "🔋 Battery Info"
        "🚪 Logout"
    )
    
    local selected=$(printf '%s\n' "${options[@]}" | rofi -dmenu -p "Quick Settings" -theme ~/.config/rofi/themes/KooL_style-2-Dark.rasi 2>/dev/null || printf '%s\n' "${options[@]}" | rofi -dmenu -p "Quick Settings")
    
    case "$selected" in
        "🔊 Volume Control")
            pavucontrol &
            ;;
        "💡 Brightness")
            ~/.config/hypr/scripts/Brightness.sh
            ;;
        "🌐 Network")
            nm-connection-editor &
            ;;
        "📶 Bluetooth")
            blueman-manager &
            ;;
        "🎨 Theme")
            ~/.config/hypr/UserScripts/ThemeSwitcher.sh
            ;;
        "🎮 Game Mode")
            ~/.config/hypr/scripts/GameMode.sh
            ;;
        "📱 Performance")
            ~/.config/hypr/UserScripts/PerformanceMonitor.sh
            ;;
        "🔒 Lock Screen")
            ~/.config/hypr/scripts/LockScreen.sh
            ;;
        "🖼️ Screenshot")
            ~/.config/hypr/scripts/ScreenShot.sh --now
            ;;
        "⚙️ System Settings")
            rofi -show drun -modi drun -theme ~/.config/rofi/themes/KooL_style-2-Dark.rasi 2>/dev/null || rofi -show drun -modi drun
            ;;
        "🔄 Refresh")
            ~/.config/hypr/scripts/Refresh.sh
            ;;
        "🌙 Night Light")
            ~/.config/hypr/scripts/toggle-hyprsunset.sh
            ;;
        "🔋 Battery Info")
            upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "percentage|time to empty" | head -2
            ;;
        "🚪 Logout")
            wlogout --protocol layer-shell
            ;;
    esac
}

# Handle direct commands
case "$1" in
    "volume")
        pavucontrol &
        ;;
    "brightness")
        ~/.config/hypr/scripts/Brightness.sh
        ;;
    "network")
        nm-connection-editor &
        ;;
    "bluetooth")
        blueman-manager &
        ;;
    "theme")
        ~/.config/hypr/UserScripts/ThemeSwitcher.sh
        ;;
    "gamemode")
        ~/.config/hypr/scripts/GameMode.sh
        ;;
    "performance")
        ~/.config/hypr/UserScripts/PerformanceMonitor.sh
        ;;
    "lock")
        ~/.config/hypr/scripts/LockScreen.sh
        ;;
    "screenshot")
        ~/.config/hypr/scripts/ScreenShot.sh --now
        ;;
    "settings")
        rofi -show drun -modi drun -theme ~/.config/rofi/themes/KooL_style-2-Dark.rasi 2>/dev/null || rofi -show drun -modi drun
        ;;
    "refresh")
        ~/.config/hypr/scripts/Refresh.sh
        ;;
    "logout")
        wlogout --protocol layer-shell
        ;;
    *)
        show_menu
        ;;
esac 