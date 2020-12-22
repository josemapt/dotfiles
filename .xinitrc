#!/bin/sh

export PATH=$HOME/.local/bin:$PATH

xmodmap ~/.Xmodpad

# make login sound
canberra-gtk-play -i service-login &

# spanish keymap
setxkbmap es&

# wallpaper
xwallpaper --zoom images/wall1.jpg &

# notifications
dunst &

# night ligth
redshift-gtk 2> /dev/null &

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
