#!/bin/bash

# Notification System Setup for Hyprland
# Configures dunst for desktop notifications

DUNST_CONFIG="$HOME/.config/dunst/dunstrc"

echo "🔔 Setting up notification system..."

# Create dunst config directory
mkdir -p "$HOME/.config/dunst"

# Create dunst configuration
cat > "$DUNST_CONFIG" << 'EOF'
[global]
    # Display
    monitor = 0
    follow = mouse
    geometry = "300x5-30+20"
    indicate_hidden = yes
    shrink = no
    transparency = 0
    notification_height = 0
    separator_height = 2
    padding = 8
    horizontal_padding = 8
    frame_width = 3
    frame_color = "#aaaaaa"
    separator_color = frame
    sort = yes
    idle_threshold = 120

    # Text
    font = "JetBrains Mono 10"
    line_height = 0
    markup = full
    format = "<b>%s</b>\n%b"
    alignment = left
    show_age_threshold = 60
    word_wrap = yes
    ellipsize = middle
    ignore_newline = no
    stack_duplicates = true
    hide_duplicate_count = false
    show_indicators = yes

    # Icons
    icon_position = left
    max_icon_size = 32
    icon_path = /usr/share/icons/gnome/16x16/status/:/usr/share/icons/gnome/16x16/devices/:/usr/share/icons/gnome/16x16/places/:/usr/share/icons/gnome/16x16/actions/:/usr/share/icons/gnome/16x16/apps/:/usr/share/icons/gnome/16x16/mimetypes/

    # History
    history_length = 20
    dmenu = /usr/bin/dmenu -p dunst:
    browser = /usr/bin/firefox -new-tab

    # Misc
    always_run_script = true
    title = Dunst
    class = Dunst
    startup_notification = false
    verbosity = mesg
    corner_radius = 0

[shortcuts]
    close = ctrl+space
    close_all = ctrl+shift+space
    history = ctrl+grave
    context = ctrl+shift+period

[urgency_low]
    background = "#2b2b2b"
    foreground = "#ffffff"
    timeout = 4

[urgency_normal]
    background = "#285577"
    foreground = "#ffffff"
    timeout = 6

[urgency_critical]
    background = "#900000"
    foreground = "#ffffff"
    frame_color = "#ff0000"
    timeout = 0
EOF

echo "✅ Dunst configuration created at $DUNST_CONFIG"

# Create autostart entry for dunst
mkdir -p "$HOME/.config/autostart"
cat > "$HOME/.config/autostart/dunst.desktop" << 'EOF'
[Desktop Entry]
Type=Application
Name=Dunst
Comment=Desktop notification daemon
Exec=dunst
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOF

echo "✅ Dunst autostart entry created"

# Test notification
if command -v dunst &> /dev/null; then
    echo "🧪 Testing notification system..."
    dunst &
    sleep 2
    notify-send "Test Notification" "Notification system is working!" -u normal
    echo "✅ Notification test sent"
else
    echo "⚠️  Dunst not found. Please install it:"
    echo "   sudo pacman -S dunst"
fi

echo "🔔 Notification system setup complete!" 