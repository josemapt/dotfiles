#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then

    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#==========================================================================================
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

exec qtile