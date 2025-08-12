#!/bin/bash

# 🌟 Dotfiles Installation Script
# This script installs and configures all dotfiles

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

# Function to check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "This script should not be run as root!"
        exit 1
    fi
}

# Function to detect package manager
detect_package_manager() {
    if command_exists pacman; then
        PACKAGE_MANAGER="pacman"
        AUR_HELPER=""
        if command_exists yay; then
            AUR_HELPER="yay"
        elif command_exists paru; then
            AUR_HELPER="paru"
        fi
    elif command_exists apt; then
        PACKAGE_MANAGER="apt"
    elif command_exists dnf; then
        PACKAGE_MANAGER="dnf"
    else
        print_error "Unsupported package manager. Please install packages manually."
        exit 1
    fi
}

# Function to install packages
install_packages() {
    print_status "Installing required packages..."
    
    if [[ "$PACKAGE_MANAGER" == "pacman" ]]; then
        # Core packages
        sudo pacman -S --noconfirm \
            hyprland \
            waybar \
            kitty \
            neovim \
            fish \
            rofi \
            swaync \
            dunst \
            grim \
            slurp \
            wl-clipboard \
            cliphist \
            wf-recorder \
            bat \
            exa \
            fd \
            ripgrep \
            fzf \
            htop \
            btop \
            neofetch \
            fastfetch \
            tldr \
            zoxide \
            starship \
            direnv \
            jq \
            yq \
            httpie \
            tmux \
            tree \
            ncdu \
            rsync \
            wget \
            curl \
            git \
            vim \
            nano
        
        # AUR packages
        if [[ -n "$AUR_HELPER" ]]; then
            print_status "Installing AUR packages with $AUR_HELPER..."
            $AUR_HELPER -S --noconfirm \
                hyprland-git \
                waybar-hyprland-git \
                nerd-fonts-fantasque-sans-mono \
                nerd-fonts-jetbrains-mono
        fi
    else
        print_warning "Please install required packages manually for your distribution."
    fi
}

# Function to backup existing configs
backup_existing_configs() {
    print_status "Backing up existing configurations..."
    
    BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    # Backup existing configs if they exist
    if [[ -d "$HOME/.config" ]]; then
        for dir in hypr waybar kitty nvim fish rofi swaync; do
            if [[ -d "$HOME/.config/$dir" ]]; then
                print_status "Backing up $dir..."
                cp -r "$HOME/.config/$dir" "$BACKUP_DIR/"
            fi
        done
    fi
    
    # Backup shell configs
    if [[ -f "$HOME/.bashrc" ]]; then
        cp "$HOME/.bashrc" "$BACKUP_DIR/"
    fi
    if [[ -f "$HOME/.zshrc" ]]; then
        cp "$HOME/.zshrc" "$BACKUP_DIR/"
    fi
    
    print_success "Backup created at: $BACKUP_DIR"
}

# Function to install dotfiles
install_dotfiles() {
    print_status "Installing dotfiles..."
    
    # Create config directory if it doesn't exist
    mkdir -p "$HOME/.config"
    
    # Copy configuration files
    if [[ -d "config" ]]; then
        cp -r config/* "$HOME/.config/"
        print_success "Configuration files installed"
    else
        print_error "Config directory not found!"
        exit 1
    fi
    
    # Copy scripts
    if [[ -d "scripts" ]]; then
        mkdir -p "$HOME/.local/bin"
        cp scripts/*.sh "$HOME/.local/bin/"
        chmod +x "$HOME/.local/bin"/*.sh
        print_success "Scripts installed"
    fi
    
    # Copy environment configuration
    if [[ -f "env.conf" ]]; then
        cp env.conf "$HOME/.config/"
        print_success "Environment configuration installed"
    fi
}

# Function to set up shell configuration
setup_shell() {
    print_status "Setting up shell configuration..."
    
    # Add environment variables to shell profiles
    ENV_SOURCE="source ~/.config/env.conf"
    
    # Bash
    if [[ -f "$HOME/.bashrc" ]]; then
        if ! grep -q "source ~/.config/env.conf" "$HOME/.bashrc"; then
            echo "" >> "$HOME/.bashrc"
            echo "# Dotfiles environment variables" >> "$HOME/.bashrc"
            echo "$ENV_SOURCE" >> "$HOME/.bashrc"
        fi
    fi
    
    # Zsh
    if [[ -f "$HOME/.zshrc" ]]; then
        if ! grep -q "source ~/.config/env.conf" "$HOME/.zshrc"; then
            echo "" >> "$HOME/.zshrc"
            echo "# Dotfiles environment variables" >> "$HOME/.zshrc"
            echo "$ENV_SOURCE" >> "$HOME/.zshrc"
        fi
    fi
    
    # Fish
    if command_exists fish; then
        mkdir -p "$HOME/.config/fish/conf.d"
        if [[ -f "config/fish/conf.d/aliases.fish" ]]; then
            cp config/fish/conf.d/aliases.fish "$HOME/.config/fish/conf.d/"
        fi
    fi
    
    print_success "Shell configuration set up"
}

# Function to set up Neovim
setup_neovim() {
    print_status "Setting up Neovim..."
    
    if command_exists nvim; then
        # Install Lazy.nvim if not already installed
        if [[ ! -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]]; then
            print_status "Installing Lazy.nvim..."
            nvim --headless -c "Lazy! sync" -c "qa" 2>/dev/null || true
        fi
        
        # Install plugins
        print_status "Installing Neovim plugins..."
        nvim --headless -c "Lazy! sync" -c "qa" 2>/dev/null || true
    fi
    
    print_success "Neovim set up"
}

# Function to set up Git configuration
setup_git() {
    print_status "Setting up Git configuration..."
    
    # Set up Git user if not already configured
    if ! git config --global user.name >/dev/null 2>&1; then
        read -p "Enter your Git username: " git_username
        git config --global user.name "$git_username"
    fi
    
    if ! git config --global user.email >/dev/null 2>&1; then
        read -p "Enter your Git email: " git_email
        git config --global user.email "$git_email"
    fi
    
    # Set up default branch name
    git config --global init.defaultBranch main
    
    print_success "Git configuration set up"
}

# Function to create symlinks for easy updates
create_symlinks() {
    print_status "Creating symlinks for easy updates..."
    
    # Create a symlink to the dotfiles directory
    if [[ ! -L "$HOME/.dotfiles" ]]; then
        ln -sf "$(pwd)" "$HOME/.dotfiles"
    fi
    
    print_success "Symlinks created"
}

# Function to set up systemd services
setup_services() {
    print_status "Setting up systemd services..."
    
    # Enable user services if they exist
    if [[ -f "$HOME/.config/systemd/user/swayidle.service" ]]; then
        systemctl --user enable swayidle.service
    fi
    
    if [[ -f "$HOME/.config/systemd/user/hyprsunset.service" ]]; then
        systemctl --user enable hyprsunset.service
    fi
    
    print_success "Systemd services set up"
}

# Function to show post-installation instructions
show_post_install() {
    echo ""
    print_success "🎉 Installation completed successfully!"
    echo ""
    echo "📋 Next steps:"
    echo "1. Log out and log back in to start Hyprland"
    echo "2. Or run: systemctl --user start hyprland-session.target"
    echo ""
    echo "🔧 Useful commands:"
    echo "- System maintenance: ~/.local/bin/maintenance.sh"
    echo "- Edit Hyprland config: nvim ~/.config/hypr/hyprland.conf"
    echo "- Edit Neovim config: nvim ~/.config/nvim/init.lua"
    echo ""
    echo "📚 Documentation:"
    echo "- Read the README.md file for detailed information"
    echo "- Check ~/.config/ for all configuration files"
    echo ""
    echo "🔄 To update your dotfiles:"
    echo "cd ~/.dotfiles && git pull && ./install.sh"
    echo ""
}

# Function to show help
show_help() {
    echo "🌟 Dotfiles Installation Script"
    echo ""
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "Options:"
    echo "  install     Install all dotfiles (default)"
    echo "  packages    Install packages only"
    echo "  configs     Install configurations only"
    echo "  backup      Backup existing configurations"
    echo "  help        Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 install   # Full installation"
    echo "  $0 packages  # Install packages only"
}

# Main installation function
main_installation() {
    print_status "Starting dotfiles installation..."
    
    check_root
    detect_package_manager
    backup_existing_configs
    install_packages
    install_dotfiles
    setup_shell
    setup_neovim
    setup_git
    create_symlinks
    setup_services
    
    show_post_install
}

# Main script logic
case "${1:-install}" in
    "install")
        main_installation
        ;;
    "packages")
        check_root
        detect_package_manager
        install_packages
        ;;
    "configs")
        backup_existing_configs
        install_dotfiles
        setup_shell
        setup_neovim
        create_symlinks
        ;;
    "backup")
        backup_existing_configs
        ;;
    "help"|*)
        show_help
        ;;
esac 