#!/bin/bash

# Define themes and their GRUB paths
declare -A THEMES
THEMES["Space Isolation"]="/boot/grub/themes/space-isolation/theme.txt"
THEMES["Minegrub"]="/boot/grub/themes/minegrub/theme.txt"
THEMES["Minegrub World Selection"]="/boot/grub/themes/minegrub-world-selection/theme.txt"
THEMES["Starfield"]="/boot/grub/themes/starfield/theme.txt"
THEMES["Sekiro"]="/boot/grub/themes/sekiro/theme.txt"
THEMES["Default (no theme)"]=""

# Show menu
CHOICE=$(printf "%s\n" "${!THEMES[@]}" | rofi -dmenu -p "Select GRUB Theme")

# If user exited without choosing
[ -z "$CHOICE" ] && exit

# Update /etc/default/grub with selected theme
if [ -z "${THEMES[$CHOICE]}" ]; then
    sudo sed -i 's|^GRUB_THEME=.*|#GRUB_THEME=""|' /etc/default/grub
else
    sudo sed -i "s|^GRUB_THEME=.*|GRUB_THEME=\"${THEMES[$CHOICE]}\"|" /etc/default/grub
fi

# Optional: Set default timeout settings
sudo sed -i "s|^GRUB_TIMEOUT=.*|GRUB_TIMEOUT=10|" /etc/default/grub
sudo sed -i "s|^GRUB_TIMEOUT_STYLE=.*|GRUB_TIMEOUT_STYLE=menu|" /etc/default/grub

# Regenerate GRUB config
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Notify user
notify-send "GRUB Theme Updated" "Applied: $CHOICE"

