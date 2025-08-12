#!/bin/bash

# Backup System for Hyprland Configuration
# Automatically backs up important configuration files

BACKUP_DIR="$HOME/.config/backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="hyprland_backup_$DATE"

echo "💾 Starting backup process..."

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to backup directory
backup_dir() {
    local source="$1"
    local dest="$BACKUP_DIR/$BACKUP_NAME/$(basename "$source")"
    
    if [[ -d "$source" ]]; then
        echo "📁 Backing up $source..."
        cp -r "$source" "$dest"
        echo "   ✅ $source backed up"
    else
        echo "   ⚠️  $source not found, skipping"
    fi
}

# Function to backup file
backup_file() {
    local source="$1"
    local dest="$BACKUP_DIR/$BACKUP_NAME/$(basename "$source")"
    
    if [[ -f "$source" ]]; then
        echo "📄 Backing up $source..."
        cp "$source" "$dest"
        echo "   ✅ $source backed up"
    else
        echo "   ⚠️  $source not found, skipping"
    fi
}

# Main backup function
main() {
    case "$1" in
        "full")
            echo "🔄 Creating full backup..."
            
            # Backup Hyprland configuration
            backup_dir "$HOME/.config/hypr"
            backup_dir "$HOME/.config/waybar"
            backup_dir "$HOME/.config/rofi"
            backup_dir "$HOME/.config/dunst"
            backup_dir "$HOME/.config/kitty"
            
            # Backup important system files
            backup_file "$HOME/.bashrc"
            backup_file "$HOME/.zshrc"
            backup_file "$HOME/.profile"
            backup_file "$HOME/.xinitrc"
            
            # Backup autostart
            backup_dir "$HOME/.config/autostart"
            
            # Create backup manifest
            echo "📋 Creating backup manifest..."
            find "$BACKUP_DIR/$BACKUP_NAME" -type f > "$BACKUP_DIR/$BACKUP_NAME/manifest.txt"
            
            # Compress backup
            echo "🗜️  Compressing backup..."
            cd "$BACKUP_DIR"
            tar -czf "${BACKUP_NAME}.tar.gz" "$BACKUP_NAME"
            rm -rf "$BACKUP_NAME"
            
            echo "✅ Full backup completed: $BACKUP_DIR/${BACKUP_NAME}.tar.gz"
            ;;
        "config")
            echo "⚙️  Creating config backup..."
            backup_dir "$HOME/.config/hypr"
            backup_dir "$HOME/.config/waybar"
            backup_dir "$HOME/.config/rofi"
            backup_dir "$HOME/.config/dunst"
            echo "✅ Config backup completed"
            ;;
        "restore")
            if [[ -z "$2" ]]; then
                echo "❌ Please specify backup file to restore"
                exit 1
            fi
            
            echo "🔄 Restoring from backup: $2"
            
            if [[ -f "$2" ]]; then
                # Extract backup
                tar -xzf "$2" -C "$BACKUP_DIR"
                backup_name=$(basename "$2" .tar.gz)
                
                # Restore files
                if [[ -d "$BACKUP_DIR/$backup_name" ]]; then
                    cp -r "$BACKUP_DIR/$backup_name"/* "$HOME/.config/"
                    echo "✅ Backup restored successfully"
                else
                    echo "❌ Invalid backup format"
                fi
            else
                echo "❌ Backup file not found: $2"
            fi
            ;;
        "list")
            echo "📋 Available backups:"
            ls -la "$BACKUP_DIR"/*.tar.gz 2>/dev/null || echo "No backups found"
            ;;
        "clean")
            echo "🧹 Cleaning old backups..."
            find "$BACKUP_DIR" -name "*.tar.gz" -mtime +30 -delete
            echo "✅ Old backups cleaned"
            ;;
        *)
            echo "Usage: $0 {full|config|restore <file>|list|clean}"
            echo "  full           - Create full backup of all configs"
            echo "  config         - Backup only Hyprland configs"
            echo "  restore <file> - Restore from backup file"
            echo "  list           - List available backups"
            echo "  clean          - Clean backups older than 30 days"
            exit 1
            ;;
    esac
}

# Run main function
main "$@" 