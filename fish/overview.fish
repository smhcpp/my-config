#!/usr/bin/env fish

# This script toggles Waybar and the Niri overview
# We use a specific signal to ensure Waybar closes immediately

if pgrep -x "waybar" > /dev/null
    # 1. Kill all instances forcefully
    killall -9 waybar
    
    # 2. Wait until they are actually gone
    while pgrep -x "waybar" > /dev/null
        sleep 0.05
    end
else
    # 1. Ensure no "zombie" processes are lingering
    killall -9 waybar > /dev/null 2>&1
    
    # 2. Start Waybar quietly
    # GTK_USE_PORTAL=0 helps skip the portal timeout we saw earlier
    env GTK_USE_PORTAL=0 waybar > /dev/null 2>&1 &
end

# Toggle niri overview
niri msg action toggle-overview
