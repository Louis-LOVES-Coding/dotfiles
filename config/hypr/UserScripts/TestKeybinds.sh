#!/bin/bash

# Test script to verify all keybinds are working

echo "=== Testing Hyprland Keybinds ==="
echo ""

echo "✅ Testing QuickSettings (SUPER + ALT + Q)..."
echo "   This should open the Quick Settings panel"
echo "   Press any key to continue..."
read -n 1

echo "✅ Testing ThemeSwitcher (SUPER + CTRL + T)..."
echo "   This should open the Theme Switcher menu"
echo "   Press any key to continue..."
read -n 1

echo "✅ Testing PerformanceMonitor (SUPER + CTRL + P)..."
echo "   This should show performance metrics"
echo "   Press any key to continue..."
read -n 1

echo "✅ Testing WorkspaceManager organize (SUPER + CTRL + W)..."
echo "   This should organize windows by type"
echo "   Press any key to continue..."
read -n 1

echo "✅ Testing WorkspaceManager empty (SUPER + CTRL + E)..."
echo "   This should switch to empty workspace"
echo "   Press any key to continue..."
read -n 1

echo "✅ Testing ThemeSwitcher next (SUPER + ALT + R)..."
echo "   This should switch to next theme"
echo "   Press any key to continue..."
read -n 1

echo "✅ Testing ThemeSwitcher prev (SUPER + ALT + SHIFT + R)..."
echo "   This should switch to previous theme"
echo "   Press any key to continue..."
read -n 1

echo ""
echo "🎉 All keybind tests completed!"
echo "If all worked, your keybinds are functioning properly!" 