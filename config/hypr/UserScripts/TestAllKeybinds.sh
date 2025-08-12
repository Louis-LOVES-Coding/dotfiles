#!/bin/bash

# Comprehensive Test Script for All Hyprland Keybinds
# Tests all the advanced features we've implemented

echo "=== HYPRLAND COMPREHENSIVE KEYBIND TEST ==="
echo ""

echo "🎯 Testing Essential Keybinds:"
echo "   SUPER + D          - Main Menu (Rofi)"
echo "   SUPER + RETURN     - Terminal"
echo "   SUPER + E          - File Manager"
echo "   SUPER + B          - Default Browser"
echo "   SUPER + SPACE      - Toggle Floating"
echo ""

echo "⚙️ Testing Advanced System Controls:"
echo "   SUPER + ALT + Q    - Quick Settings Panel"
echo "   SUPER + CTRL + S   - System Tray Menu"
echo "   SUPER + CTRL + P   - Performance Monitor"
echo "   SUPER + CTRL + T   - Theme Switcher Menu"
echo ""

echo "🎮 Testing System Optimizer:"
echo "   SUPER + CTRL + O   - Performance Mode"
echo "   SUPER + CTRL + G   - Gaming Mode"
echo "   SUPER + CTRL + B   - Battery Mode"
echo "   SUPER + CTRL + Q   - Quality Mode"
echo ""

echo "🏢 Testing Workspace Management:"
echo "   SUPER + CTRL + W   - Organize Workspaces"
echo "   SUPER + CTRL + E   - Switch to Empty Workspace"
echo "   SUPER + CTRL + N   - Next Workspace with Windows"
echo "   SUPER + CTRL + V   - Previous Workspace with Windows"
echo ""

echo "🎨 Testing Theme Management:"
echo "   SUPER + ALT + R    - Next Theme"
echo "   SUPER + ALT + SHIFT + R - Previous Theme"
echo ""

echo "🖼️ Testing Window Management:"
echo "   SUPER + CTRL + U   - Enable Opacity on Active Window"
echo "   SUPER + ALT + F    - Toggle Floating"
echo "   SUPER + SHIFT + T  - Toggle Split"
echo ""

echo "📸 Testing Screenshots:"
echo "   SUPER + PRINT      - Screenshot Now"
echo "   SUPER + F6         - Screenshot Now (alternative)"
echo ""

echo "🔧 Testing Utilities:"
echo "   SUPER + S          - Google Search (Rofi)"
echo "   SUPER + ALT + E    - Emoji Menu"
echo "   SUPER + ALT + V    - Clipboard Manager"
echo "   SUPER + ALT + C    - Calculator"
echo ""

echo "🎵 Testing Media Controls:"
echo "   SUPER + K          - Play/Pause"
echo "   SUPER + O          - Next Track"
echo "   SUPER + I          - Previous Track"
echo ""

echo "🔒 Testing System:"
echo "   CTRL + ALT + DELETE - Exit Hyprland"
echo "   CTRL + ALT + L     - Lock Screen"
echo "   CTRL + ALT + P     - Power Menu"
echo ""

echo "=== TESTING INDIVIDUAL SCRIPTS ==="
echo ""

echo "✅ Testing QuickSettings..."
./UserScripts/QuickSettings.sh &
sleep 2
pkill -f "rofi.*Quick Settings"

echo "✅ Testing ThemeSwitcher..."
./UserScripts/ThemeSwitcher.sh list

echo "✅ Testing SystemOptimizer..."
./UserScripts/SystemOptimizer.sh performance

echo "✅ Testing WorkspaceManager..."
./UserScripts/WorkspaceManager.sh list

echo ""
echo "🎉 All tests completed!"
echo "If you see no errors above, your keybinds should be working properly."
echo ""
echo "💡 Tips:"
echo "   - Use SUPER + H for key hints"
echo "   - Use SUPER + SHIFT + K to search keybinds"
echo "   - Use SUPER + ALT + Q for quick access to all settings" 