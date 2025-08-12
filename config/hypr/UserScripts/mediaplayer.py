#!/usr/bin/env python3
import json
import subprocess
import os

def get_media_info():
    try:
        artist = subprocess.check_output(["playerctl", "metadata", "artist"], stderr=subprocess.PIPE).decode().strip()
        title = subprocess.check_output(["playerctl", "metadata", "title"], stderr=subprocess.PIPE).decode().strip()
        status = subprocess.check_output(["playerctl", "status"], stderr=subprocess.PIPE).decode().strip()
        
        if status == "Playing":
            return {"text": f"{artist} - {title}", "tooltip": f"Playing: {title}", "class": "Playing", "alt": "Playing"}
        elif status == "Paused":
            return {"text": f"{artist} - {title}", "tooltip": f"Paused: {title}", "class": "Paused", "alt": "Paused"}
    except:
        return {"text": "No media", "tooltip": "No media playing", "class": "Stopped", "alt": "Stopped"}

# Send notification when script is called directly (e.g., from keybinds)
if __name__ == "__main__":
    media_info = get_media_info()
    status = media_info.get("alt", "Stopped")
    if status != "Stopped":
        subprocess.run([
            "notify-send", 
            "-a", "Media Player", 
            "-h", "string:x-canonical-private-synchronous:media",
            f"{status}: {media_info['text']}",
            "-t", "2000"  # Notification timeout (2 seconds)
        ])
    print(json.dumps(media_info))  # Still output JSON for Waybar
