# Hyprland Configuration

A clean and organized Hyprland configuration setup.

## Directory Structure

```
hypr/
├── hyprland.conf              # Main configuration file
├── hypridle.conf              # Idle configuration
├── hyprlock.conf              # Lock screen configuration
├── monitors.conf              # Monitor settings
├── workspaces.conf            # Workspace configuration
├── application-style.conf     # Application-specific styling
├── initial-boot.sh            # Initial boot script
├── current_theme              # Current theme indicator
├── .initial_startup_done      # Startup completion marker
│
├── configs/                   # Core configuration files
│   └── Keybinds.conf         # Default keybindings
│
├── UserConfigs/              # User-specific configurations
│   ├── 01-UserDefaults.conf  # Default applications
│   ├── ENVariables.conf      # Environment variables
│   ├── Laptops.conf          # Laptop-specific settings
│   ├── LaptopDisplay.conf    # Laptop display settings
│   ├── Startup_Apps.conf     # Startup applications
│   ├── UserAnimations.conf   # Animation settings
│   ├── UserDecorations.conf  # Decoration settings
│   ├── UserKeybinds.conf     # Custom keybindings
│   ├── UserSettings.conf     # Main user settings
│   └── WindowRules.conf      # Window rules
│
├── scripts/                  # System scripts
│   ├── AirplaneMode.sh
│   ├── Animations.sh
│   ├── Brightness.sh
│   ├── ChangeBlur.sh
│   ├── DarkLight.sh
│   ├── GameMode.sh
│   ├── MediaCtrl.sh
│   ├── Refresh.sh
│   ├── ScreenShot.sh
│   ├── Volume.sh
│   └── ... (other utility scripts)
│
├── UserScripts/              # User custom scripts
│   ├── QuickSettings.sh
│   ├── ThemeSwitcher.sh
│   ├── WallpaperSelect.sh
│   ├── Weather.sh
│   └── ... (other user scripts)
│
├── animations/               # Animation presets (backed up)
│   ├── 00-default.conf
│   ├── 03- Disable Animation.conf
│   └── backup/              # Other animation presets
│
├── Monitor_Profiles/         # Monitor profile configurations
│   ├── default.conf
│   └── README
│
├── wallust/                  # Wallust wallpaper configuration
│   └── wallust-hyprland.conf
│
└── wallpaper_effects/        # Wallpaper effect configurations
```

## Quick Start

1. **Reload configuration**: `hyprctl reload`
2. **Check status**: `hyprctl version`
3. **View logs**: `journalctl --user -f -u hyprland`

## Maintenance

- **Backup**: All removed files are backed up in `animations/backup/`
- **Clean**: Removed duplicate and unused configuration files
- **Organized**: Clear separation between system and user configurations

## Notes

- Animation presets are backed up but not actively used (custom animations in UserAnimations.conf)
- Old window rules and error logs have been removed
- Duplicate hyprlock configuration removed
- Version tracking file removed 