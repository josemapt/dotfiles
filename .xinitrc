#!/bin/sh

export PATH=$HOME/.local/bin:$PATH

# spanish keymap
setxkbmap es&

# wallpaper
feh --no-fehbg --bg-scale '/home/josema/images/wall1.jpg' &

# notifications
dunst &

# scripts
/home/josema/scripts/battery.sh &

# touchpad settings
xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Tapping Enabled" 1 &
xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Natural Scrolling Enabled" 1 &

# Disable DPMS
xset -dpms
xset s off
xset s noblank
xset s noexpose
xset s 0 0

exec bspwm