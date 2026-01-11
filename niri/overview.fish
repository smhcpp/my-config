#!/usr/bin/env fish
set STATE_FILE /tmp/niri-overview-active
if grep -q true $STATE_FILE 2>/dev/null
    waybar > /dev/null 2>&1 &
    echo "false" > $STATE_FILE
else
    pkill -f "waybar"
    echo "true" > $STATE_FILE
end
