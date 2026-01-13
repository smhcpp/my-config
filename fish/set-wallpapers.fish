#!/usr/bin/env fish
pkill swaybg
if test (count $argv) -eq 0
    swaybg -i /home/mortimertz/Photos/wallpapers/1.jpg &
else
    swaybg -i /home/mortimertz/Photos/wallpapers/$argv[1].jpg &
end
