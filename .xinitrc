#!/bin/sh

export PATH=$HOME/.local/bin:$PATH

# make login sound
canberra-gtk-play -i service-login &

# spanish keymap
setxkbmap es &

# notifications
dunst &

# wallpaper
hsetroot -fill ~/multimedia/wall1.jpg &

# scripts
~/scripts/battery.sh &
~/scripts/night_light.sh &

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