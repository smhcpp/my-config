#!/usr/bin/env fish

set option (echo -e "⏻  Shutdown\n  Reboot\n  Suspend\n  Lock" | fuzzel --dmenu --prompt "Power: " --width 30 --lines 4)

switch "$option"
    case "*Shutdown*"
        shutdown now
    case "*Reboot*"
        reboot
    case "*Suspend*"
        systemctl suspend
    case "*Lock*"
        # Use your lock command here (swaylock, etc)
        # swaylock -f
end
