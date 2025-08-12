#!/bin/bash

# Performance Monitor for Hyprland
# Shows real-time system performance metrics

echo "=== Hyprland Performance Monitor ==="
echo "Press Ctrl+C to exit"
echo ""

while true; do
    clear
    echo "=== Hyprland Performance Monitor ==="
    echo "Time: $(date '+%H:%M:%S')"
    echo ""
    
    # CPU Usage
    echo "CPU Usage:"
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1 | head -1)
    echo "$cpu_usage%"
    
    # Memory Usage
    echo "Memory Usage:"
    mem_info=$(free -h | grep "Mem:" | awk '{print $3 "/" $2 " (" $3/$2*100 "%)"}')
    echo "$mem_info"
    
    # Disk Usage
    echo "Disk Usage:"
    df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}'
    
    # GPU Usage (if available)
    if command -v nvidia-smi &> /dev/null; then
        echo "GPU Usage:"
        nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits
    fi
    
    # Hyprland specific info
    echo ""
    echo "Hyprland Info:"
    hyprctl version | head -1
    
    # Active windows count
    echo "Active Windows: $(hyprctl clients | grep -c 'Window')"
    
    # Workspace info
    echo "Current Workspace: $(hyprctl activeworkspace | head -1 | awk '{print $2}')"
    
    # FPS (if available)
    if command -v glxgears &> /dev/null; then
        echo "FPS: $(glxgears -info | grep -o '[0-9]*\.[0-9]* fps' | head -1)"
    fi
    
    sleep 2
done 