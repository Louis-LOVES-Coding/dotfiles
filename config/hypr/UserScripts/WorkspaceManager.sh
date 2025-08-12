#!/bin/bash

# Advanced Workspace Manager for Hyprland
# Provides workspace organization and management features

case "$1" in
    "list")
        # List all workspaces with their windows
        hyprctl workspaces | grep -E "workspace|Window" | sed 's/^[[:space:]]*//'
        ;;
    "clean")
        # Move all windows from current workspace to workspace 1
        current_ws=$(hyprctl activeworkspace | head -1 | awk '{print $2}')
        hyprctl dispatch movetoworkspace 1
        hyprctl dispatch workspace 1
        ;;
    "organize")
        # Organize windows by type
        hyprctl dispatch movetoworkspace 1 class:firefox
        hyprctl dispatch movetoworkspace 1 class:google-chrome
        hyprctl dispatch movetoworkspace 1 class:chromium
        hyprctl dispatch movetoworkspace 2 class:kitty
        hyprctl dispatch movetoworkspace 2 class:alacritty
        hyprctl dispatch movetoworkspace 2 class:foot
        hyprctl dispatch movetoworkspace 3 class:thunar
        hyprctl dispatch movetoworkspace 3 class:nautilus
        hyprctl dispatch movetoworkspace 3 class:dolphin
        hyprctl dispatch movetoworkspace 4 class:codium
        hyprctl dispatch movetoworkspace 4 class:code
        hyprctl dispatch movetoworkspace 5 class:discord
        hyprctl dispatch movetoworkspace 5 class:telegram
        hyprctl dispatch movetoworkspace 5 class:whatsapp-for-linux
        ;;
    "empty")
        # Find and switch to empty workspace
        empty_ws=$(hyprctl workspaces | grep -E "workspace [0-9]+" | awk '{print $2}' | sort -n | while read ws; do
            if ! hyprctl workspaces | grep -A 20 "workspace $ws" | grep -q "Window"; then
                echo $ws
                break
            fi
        done)
        if [ ! -z "$empty_ws" ]; then
            hyprctl dispatch workspace $empty_ws
        else
            hyprctl dispatch workspace 10
        fi
        ;;
    "next")
        # Switch to next workspace with windows
        current_ws=$(hyprctl activeworkspace | head -1 | awk '{print $2}')
        next_ws=$(hyprctl workspaces | grep -E "workspace [0-9]+" | awk '{print $2}' | sort -n | while read ws; do
            if [ "$ws" -gt "$current_ws" ] && hyprctl workspaces | grep -A 20 "workspace $ws" | grep -q "Window"; then
                echo $ws
                break
            fi
        done)
        if [ ! -z "$next_ws" ]; then
            hyprctl dispatch workspace $next_ws
        fi
        ;;
    "prev")
        # Switch to previous workspace with windows
        current_ws=$(hyprctl activeworkspace | head -1 | awk '{print $2}')
        prev_ws=$(hyprctl workspaces | grep -E "workspace [0-9]+" | awk '{print $2}' | sort -nr | while read ws; do
            if [ "$ws" -lt "$current_ws" ] && hyprctl workspaces | grep -A 20 "workspace $ws" | grep -q "Window"; then
                echo $ws
                break
            fi
        done)
        if [ ! -z "$prev_ws" ]; then
            hyprctl dispatch workspace $prev_ws
        fi
        ;;
    *)
        echo "Usage: $0 {list|clean|organize|empty|next|prev}"
        echo "  list     - List all workspaces with windows"
        echo "  clean    - Move all windows to workspace 1"
        echo "  organize - Organize windows by type"
        echo "  empty    - Switch to empty workspace"
        echo "  next     - Switch to next workspace with windows"
        echo "  prev     - Switch to previous workspace with windows"
        ;;
esac 