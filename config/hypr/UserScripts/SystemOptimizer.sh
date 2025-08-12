#!/bin/bash

# Enhanced System Optimizer for Hyprland
# Optimizes system performance and startup

echo "🚀 Starting System Optimization..."

# Function to optimize CPU governor
optimize_cpu() {
    echo "⚡ Optimizing CPU governor..."
    if command -v cpupower &> /dev/null; then
        sudo cpupower frequency-set -g performance
        echo "   CPU governor set to performance"
    fi
}

# Function to optimize memory
optimize_memory() {
    echo "🧠 Optimizing memory..."
    # Clear page cache
    sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"
    echo "   Page cache cleared"
    
    # Optimize swappiness
    sudo sysctl vm.swappiness=10
    echo "   Swappiness set to 10"
}

# Function to optimize disk I/O
optimize_disk() {
    echo "💾 Optimizing disk I/O..."
    # Set I/O scheduler to none for NVMe, bfq for others
    for disk in /sys/block/sd* /sys/block/nvme*; do
        if [[ -d "$disk" ]]; then
            disk_name=$(basename "$disk")
            if [[ "$disk_name" == nvme* ]]; then
                echo "none" | sudo tee "$disk/queue/scheduler" > /dev/null
            else
                echo "bfq" | sudo tee "$disk/queue/scheduler" > /dev/null
            fi
        fi
    done
    echo "   I/O schedulers optimized"
}

# Function to optimize network
optimize_network() {
    echo "🌐 Optimizing network..."
    # Increase TCP buffer sizes
    sudo sysctl -w net.core.rmem_max=16777216
    sudo sysctl -w net.core.wmem_max=16777216
    sudo sysctl -w net.ipv4.tcp_rmem="4096 87380 16777216"
    sudo sysctl -w net.ipv4.tcp_wmem="4096 65536 16777216"
    echo "   Network buffers optimized"
}

# Function to optimize graphics
optimize_graphics() {
    echo "🎨 Optimizing graphics..."
    # Set GPU performance mode if available
    if command -v nvidia-smi &> /dev/null; then
        nvidia-smi -pm 1
        nvidia-smi -ac 4004,1590
        echo "   NVIDIA GPU optimized"
    fi
    
    # Optimize Mesa settings
    export MESA_GL_VERSION_OVERRIDE=4.6
    export MESA_GLSL_VERSION_OVERRIDE=460
    echo "   Mesa settings optimized"
}

# Function to clean temporary files
clean_temp() {
    echo "🧹 Cleaning temporary files..."
    rm -rf /tmp/*
    rm -rf ~/.cache/*
    echo "   Temporary files cleaned"
}

# Function to optimize startup applications
optimize_startup() {
    echo "🚀 Optimizing startup applications..."
    # Kill unnecessary services
    pkill -f "evolution"
    pkill -f "tracker"
    pkill -f "zeitgeist"
    echo "   Unnecessary services stopped"
}

# Function to set performance mode
set_performance_mode() {
    echo "⚡ Setting performance mode..."
    # Set performance mode for power profiles
    if command -v powerprofilesctl &> /dev/null; then
        powerprofilesctl set performance
        echo "   Power profile set to performance"
    fi
}

# Main optimization function
main() {
    case "$1" in
        "cpu")
            optimize_cpu
            ;;
        "memory")
            optimize_memory
            ;;
        "disk")
            optimize_disk
            ;;
        "network")
            optimize_network
            ;;
        "graphics")
            optimize_graphics
            ;;
        "clean")
            clean_temp
            ;;
        "startup")
            optimize_startup
            ;;
        "performance")
            set_performance_mode
            ;;
        "all")
            optimize_cpu
            optimize_memory
            optimize_disk
            optimize_network
            optimize_graphics
            clean_temp
            optimize_startup
            set_performance_mode
            ;;
        *)
            echo "Usage: $0 {cpu|memory|disk|network|graphics|clean|startup|performance|all}"
            echo "  cpu        - Optimize CPU governor"
            echo "  memory     - Optimize memory settings"
            echo "  disk       - Optimize disk I/O"
            echo "  network    - Optimize network settings"
            echo "  graphics   - Optimize graphics settings"
            echo "  clean      - Clean temporary files"
            echo "  startup    - Optimize startup applications"
            echo "  performance- Set performance mode"
            echo "  all        - Run all optimizations"
            exit 1
            ;;
    esac
    
    echo "✅ Optimization complete!"
}

# Run main function with arguments
main "$@" 