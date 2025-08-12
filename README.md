# 🎯 Louix's Dotfiles

> A comprehensive collection of my Linux configuration files for a modern, efficient, and beautiful desktop environment.

![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-1a1b26?style=for-the-badge&logo=hyprland&logoColor=white)
![Neovim](https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![Fish Shell](https://img.shields.io/badge/Fish_Shell-4EAA25?style=for-the-badge&logo=fish&logoColor=white)

## 🚀 **Features**

### **Desktop Environment**
- **Hyprland** - Modern Wayland compositor with smooth animations
- **Waybar** - Highly customizable status bar with system monitoring
- **SwayNC** - Notification center with media controls
- **Rofi** - Application launcher and menu system

### **Terminal & Development**
- **Kitty** - Fast, feature-rich terminal emulator
- **Neovim** - Modern Vim with LSP support and plugins
- **Fish Shell** - User-friendly shell with smart features

### **System Tools**
- **System Maintenance Script** - Automated system optimization
- **Environment Configuration** - Comprehensive system variables
- **Backup System** - Configuration backup and restoration

## 📸 **Screenshots**

*[Add screenshots of your setup here]*

## 🛠️ **Quick Installation**

### **Prerequisites**
- Arch Linux (or Arch-based distribution)
- Git
- A package manager (pacman + yay/paru)

### **1. Clone the Repository**
```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### **2. Run the Installation Script**
```bash
./install.sh
```

### **3. Manual Installation (Alternative)**
```bash
# Install required packages
sudo pacman -S hyprland waybar kitty neovim fish rofi swaync

# Copy configuration files
cp -r config/* ~/.config/

# Make scripts executable
chmod +x scripts/*.sh

# Source environment variables
echo "source ~/.config/env.conf" >> ~/.bashrc
echo "source ~/.config/env.conf" >> ~/.zshrc
```

## 📁 **Directory Structure**

```
dotfiles/
├── config/                 # Configuration files
│   ├── hypr/              # Hyprland configuration
│   ├── waybar/            # Status bar configuration
│   ├── kitty/             # Terminal configuration
│   ├── nvim/              # Neovim configuration
│   ├── fish/              # Fish shell configuration
│   ├── rofi/              # Application launcher
│   ├── swaync/            # Notification center
│   └── ...                # Other configs
├── scripts/               # Utility scripts
│   ├── install.sh         # Installation script
│   ├── maintenance.sh     # System maintenance
│   └── backup.sh          # Backup utilities
├── .gitignore            # Git ignore rules
└── README.md             # This file
```

## 🎨 **Customization**

### **Themes**
- **Hyprland**: Edit `config/hypr/UserConfigs/UserDecorations.conf`
- **Waybar**: Modify `config/waybar/style.css`
- **Kitty**: Choose themes from `config/kitty/kitty-themes/`
- **Neovim**: Configure in `config/nvim/lua/plugins.lua`

### **Key Bindings**
- **Hyprland**: `Super + Return` (terminal), `Super + D` (launcher)
- **Neovim**: `Space` (leader), `Space + e` (file explorer)
- **Fish**: `Ctrl + r` (history search)

## 🔧 **Maintenance**

### **System Updates**
```bash
# Full system maintenance
~/dotfiles/scripts/maintenance.sh full

# Update packages only
~/dotfiles/scripts/maintenance.sh update

# Clean cache
~/dotfiles/scripts/maintenance.sh clean
```

### **Backup Configuration**
```bash
# Create backup
~/dotfiles/scripts/backup.sh create

# Restore backup
~/dotfiles/scripts/backup.sh restore <backup-name>
```

## 🐛 **Troubleshooting**

### **Common Issues**

1. **Waybar not showing**
   ```bash
   pgrep waybar || waybar
   ```

2. **Hyprland not starting**
   ```bash
   journalctl --user -u hyprland-session.target
   ```

3. **Neovim plugins not loading**
   ```bash
   nvim --headless -c "Lazy! sync" -c "qa"
   ```

### **Performance Issues**
```bash
# Check system health
~/dotfiles/scripts/maintenance.sh health

# Optimize system
~/dotfiles/scripts/maintenance.sh optimize
```

## 📚 **Dependencies**

### **Core Packages**
- `hyprland` - Wayland compositor
- `waybar` - Status bar
- `kitty` - Terminal emulator
- `neovim` - Text editor
- `fish` - Shell
- `rofi` - Application launcher
- `swaync` - Notification center

### **Additional Utilities**
- `bat` - Better cat
- `exa` - Better ls
- `fd` - Better find
- `ripgrep` - Better grep
- `fzf` - Fuzzy finder
- `htop` - Process viewer
- `btop` - Better htop

## 🤝 **Contributing**

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 **Acknowledgments**

- [Hyprland](https://hyprland.org/) - Modern Wayland compositor
- [JaKooLit](https://github.com/JaKooLit) - Original Hyprland configuration inspiration
- [Neovim](https://neovim.io/) - Modern Vim
- [Fish Shell](https://fishshell.com/) - User-friendly shell

## 📞 **Contact**

- **GitHub**: [@yourusername](https://github.com/yourusername)
- **Email**: your.email@example.com

---

**⭐ If you find this useful, please give it a star!** 