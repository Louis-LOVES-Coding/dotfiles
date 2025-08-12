#!/bin/bash

# Advanced Theme Switcher for Hyprland
# Switches between different visual themes

THEME_DIR="$HOME/.config/hypr/themes"
CURRENT_THEME_FILE="$HOME/.config/hypr/current_theme"

# Available themes (using actual wallust themes)
themes=(
    "default"
    "Nord"
    "Dracula"
    "Tokyo-Night"
    "Catppuccin-Mocha"
    "Gruvbox"
    "Rosé-Pine"
    "Everforest-Dark-Soft"
    "Kanagawa-Wave"
    "Monokai-Pro"
    "Solarized-Dark"
    "One-Dark"
)

switch_theme() {
    local theme=$1
    
    # Update wallust theme
    if command -v wallust &> /dev/null; then
        if [ "$theme" != "default" ]; then
            wallust theme $theme 2>/dev/null && wallust run hyprland
        else
            # For default theme, just reload hyprland
            hyprctl reload
        fi
    fi
    
    # Update GTK theme (if available)
    if command -v gsettings &> /dev/null; then
        case $theme in
            "dark")
                gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
                ;;
            "light")
                gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
                ;;
        esac
    fi
    
    # Update Qt theme
    if command -v qt5ct &> /dev/null; then
        case $theme in
            "dark")
                qt5ct --style=dark
                ;;
            "light")
                qt5ct --style=light
                ;;
        esac
    fi
    
    # Save current theme
    echo $theme > $CURRENT_THEME_FILE
    
    # Refresh Hyprland
    hyprctl reload
    
    # Show notification
    if command -v notify-send &> /dev/null; then
        notify-send "Theme Switcher" "Switched to $theme theme"
    fi
}

show_theme_menu() {
    local selected=$(printf '%s\n' "${themes[@]}" | rofi -dmenu -p "Select Theme" -theme ~/.config/rofi/themes/KooL_style-2-Dark.rasi)
    
    if [ ! -z "$selected" ]; then
        switch_theme "$selected"
    fi
}

# Main script logic
case "$1" in
    "list")
        printf '%s\n' "${themes[@]}"
        ;;
    "current")
        if [ -f "$CURRENT_THEME_FILE" ]; then
            cat "$CURRENT_THEME_FILE"
        else
            echo "default"
        fi
        ;;
    "next")
        current=$(cat "$CURRENT_THEME_FILE" 2>/dev/null || echo "default")
        for i in "${!themes[@]}"; do
            if [[ "${themes[$i]}" == "$current" ]]; then
                next_index=$(( (i + 1) % ${#themes[@]} ))
                switch_theme "${themes[$next_index]}"
                break
            fi
        done
        ;;
    "prev")
        current=$(cat "$CURRENT_THEME_FILE" 2>/dev/null || echo "default")
        for i in "${!themes[@]}"; do
            if [[ "${themes[$i]}" == "$current" ]]; then
                prev_index=$(( (i - 1 + ${#themes[@]}) % ${#themes[@]} ))
                switch_theme "${themes[$prev_index]}"
                break
            fi
        done
        ;;
    *)
        if [ ! -z "$1" ]; then
            switch_theme "$1"
        else
            show_theme_menu
        fi
        ;;
esac 