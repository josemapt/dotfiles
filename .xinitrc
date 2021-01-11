#!/bin/sh

export PATH=$HOME/.local/bin:$PATH

# xdg files
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# remove less histry file
export LESSHISTFILE=-

# make login sound
canberra-gtk-play -i service-login &

# spanish keymap
setxkbmap es &

# notifications
dunst &

# transparency
picom --experimental-backends &

# wallpaper
hsetroot -fill ~/images/wall1.jpg &

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

exec dwm