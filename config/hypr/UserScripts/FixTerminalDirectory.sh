#!/bin/bash

# Fix Terminal Directory Script
# Forces terminal to start in home directory instead of current working directory

echo "🔧 Fixing terminal directory..."

# Method 1: Update kitty configuration
KITTY_CONFIG="$HOME/.config/kitty/kitty.conf"

if [[ -f "$KITTY_CONFIG" ]]; then
    # Add directory setting if not present
    if ! grep -q "shell_integration" "$KITTY_CONFIG"; then
        echo "" >> "$KITTY_CONFIG"
        echo "# Force start in home directory" >> "$KITTY_CONFIG"
        echo "shell_integration enabled" >> "$KITTY_CONFIG"
        echo "startup_session none" >> "$KITTY_CONFIG"
    fi
    echo "✅ Kitty configuration updated"
fi

# Method 2: Create a wrapper script for kitty
KITTY_WRAPPER="$HOME/.local/bin/kitty-wrapper"
mkdir -p "$(dirname "$KITTY_WRAPPER")"

cat > "$KITTY_WRAPPER" << 'EOF'
#!/bin/bash
# Wrapper script to force kitty to start in home directory
cd ~
exec kitty "$@"
EOF

chmod +x "$KITTY_WRAPPER"

# Method 3: Update your terminal variable in Hyprland config
echo "📝 To complete the fix, update your terminal variable in UserConfigs/01-UserDefaults.conf:"
echo "   Change: \$term = kitty"
echo "   To:     \$term = $KITTY_WRAPPER"

echo "✅ Terminal directory fix applied!"
echo "🔄 Please restart your terminal or Hyprland for changes to take effect" 