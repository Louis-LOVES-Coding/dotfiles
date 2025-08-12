#!/bin/bash

# 🌟 System Maintenance Script
# This script helps maintain and optimize your Arch Linux system

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to update system packages
update_system() {
    print_status "Updating system packages..."
    
    # Update main repositories
    sudo pacman -Syu --noconfirm
    
    # Update AUR packages if yay is available
    if command_exists yay; then
        print_status "Updating AUR packages with yay..."
        yay -Sua --noconfirm
    elif command_exists paru; then
        print_status "Updating AUR packages with paru..."
        paru -Sua --noconfirm
    fi
    
    print_success "System packages updated successfully!"
}

# Function to clean package cache
clean_cache() {
    print_status "Cleaning package cache..."
    
    # Clean pacman cache
    sudo pacman -Sc --noconfirm
    
    # Clean AUR cache
    if command_exists yay; then
        yay -Sc --noconfirm
    elif command_exists paru; then
        paru -Sc --noconfirm
    fi
    
    # Clean orphaned packages
    sudo pacman -Rns $(pacman -Qtdq) --noconfirm 2>/dev/null || true
    
    print_success "Package cache cleaned successfully!"
}

# Function to clean temporary files
clean_temp() {
    print_status "Cleaning temporary files..."
    
    # Clean system temp
    sudo rm -rf /tmp/*
    sudo rm -rf /var/tmp/*
    
    # Clean user temp
    rm -rf ~/.cache/*
    rm -rf ~/.local/share/Trash/*
    
    # Clean browser cache
    rm -rf ~/.cache/mozilla/firefox/*/cache2
    rm -rf ~/.cache/google-chrome/Default/Cache
    rm -rf ~/.cache/brave/Browser/Cache
    
    print_success "Temporary files cleaned successfully!"
}

# Function to optimize system performance
optimize_system() {
    print_status "Optimizing system performance..."
    
    # Optimize CPU governor
    if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors ]; then
        echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor >/dev/null 2>&1 || true
    fi
    
    # Optimize swappiness
    echo 10 | sudo tee /proc/sys/vm/swappiness >/dev/null 2>&1 || true
    
    # Clear memory cache
    echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null 2>&1 || true
    
    print_success "System performance optimized!"
}

# Function to backup important configurations
backup_configs() {
    print_status "Creating configuration backup..."
    
    BACKUP_DIR="$HOME/config-backups"
    BACKUP_NAME="config-backup-$(date +%Y%m%d-%H%M%S).tar.gz"
    
    mkdir -p "$BACKUP_DIR"
    
    tar -czf "$BACKUP_DIR/$BACKUP_NAME" \
        ~/.config \
        ~/.local/share \
        ~/.cache \
        ~/.ssh \
        ~/.gnupg \
        ~/.gitconfig \
        ~/.bashrc \
        ~/.zshrc \
        ~/.profile \
        2>/dev/null || true
    
    print_success "Configuration backup created: $BACKUP_DIR/$BACKUP_NAME"
}

# Function to check system health
check_health() {
    print_status "Checking system health..."
    
    # Check disk space
    DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    if [ "$DISK_USAGE" -gt 80 ]; then
        print_warning "Disk usage is high: ${DISK_USAGE}%"
    else
        print_success "Disk usage is normal: ${DISK_USAGE}%"
    fi
    
    # Check memory usage
    MEM_USAGE=$(free | awk 'NR==2{printf "%.1f", $3*100/$2}')
    if (( $(echo "$MEM_USAGE > 80" | bc -l) )); then
        print_warning "Memory usage is high: ${MEM_USAGE}%"
    else
        print_success "Memory usage is normal: ${MEM_USAGE}%"
    fi
    
    # Check for broken packages
    if pacman -Qk 2>&1 | grep -q "broken"; then
        print_warning "Broken packages detected. Run 'pacman -Qk' for details."
    else
        print_success "No broken packages detected."
    fi
    
    # Check for failed systemd services
    FAILED_SERVICES=$(systemctl --failed --no-legend --no-pager | wc -l)
    if [ "$FAILED_SERVICES" -gt 0 ]; then
        print_warning "Failed systemd services detected: $FAILED_SERVICES"
    else
        print_success "All systemd services are running properly."
    fi
}

# Function to show system information
show_info() {
    print_status "System Information:"
    echo "OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
    echo "Kernel: $(uname -r)"
    echo "Architecture: $(uname -m)"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Shell: $SHELL"
    echo "Desktop Environment: $XDG_CURRENT_DESKTOP"
    echo "Display Server: $XDG_SESSION_TYPE"
}

# Function to install useful packages
install_useful_packages() {
    print_status "Installing useful packages..."
    
    # Essential utilities
    PACKAGES=(
        "bat"           # Better cat
        "exa"           # Better ls
        "fd"            # Better find
        "ripgrep"       # Better grep
        "fzf"           # Fuzzy finder
        "htop"          # Process viewer
        "btop"          # Better htop
        "neofetch"      # System info
        "fastfetch"     # Fast system info
        "tldr"          # Simplified man pages
        "zoxide"        # Better cd
        "starship"      # Better prompt
        "direnv"        # Directory environments
        "jq"            # JSON processor
        "yq"            # YAML processor
        "httpie"        # HTTP client
        "tmux"          # Terminal multiplexer
        "tree"          # Directory tree
        "ncdu"          # Disk usage analyzer
        "rsync"         # File synchronization
        "wget"          # Web downloader
        "curl"          # Web client
        "git"           # Version control
        "vim"           # Text editor
        "nano"          # Simple editor
    )
    
    for package in "${PACKAGES[@]}"; do
        if ! pacman -Q "$package" >/dev/null 2>&1; then
            print_status "Installing $package..."
            sudo pacman -S "$package" --noconfirm
        fi
    done
    
    print_success "Useful packages installation completed!"
}

# Function to show help
show_help() {
    echo "🌟 System Maintenance Script"
    echo ""
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "Options:"
    echo "  update      Update system packages"
    echo "  clean       Clean cache and temporary files"
    echo "  optimize    Optimize system performance"
    echo "  backup      Backup important configurations"
    echo "  health      Check system health"
    echo "  info        Show system information"
    echo "  install     Install useful packages"
    echo "  full        Run all maintenance tasks"
    echo "  help        Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 update    # Update packages only"
    echo "  $0 full      # Run complete maintenance"
}

# Main script logic
case "${1:-help}" in
    "update")
        update_system
        ;;
    "clean")
        clean_cache
        clean_temp
        ;;
    "optimize")
        optimize_system
        ;;
    "backup")
        backup_configs
        ;;
    "health")
        check_health
        ;;
    "info")
        show_info
        ;;
    "install")
        install_useful_packages
        ;;
    "full")
        print_status "Running complete system maintenance..."
        update_system
        clean_cache
        clean_temp
        optimize_system
        backup_configs
        check_health
        print_success "Complete maintenance finished!"
        ;;
    "help"|*)
        show_help
        ;;
esac 