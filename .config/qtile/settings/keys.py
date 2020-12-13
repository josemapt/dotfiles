from libqtile.config import Key
from libqtile.command import lazy
from libqtile import extension

mod = "mod4"
terminal = "alacritty"

keys = [
    #-----------------------------------------------------
    Key([mod], "Tab",  lazy.screen.toggle_group()),     # Move to the last visited group

    Key([mod], "Up",  lazy.layout.grow()),              # Increases window size
    Key([mod], "Down",  lazy.layout.shrink()),          # Decreases window size

    Key([mod], "space",  lazy.layout.flip()),           # Rotate windows

    #-----------------------------------------------------
    Key([mod, "shift"], "q", lazy.window.kill()),       # Kill actual window

    Key([mod, "shift"], "r", lazy.restart()),           # Restart qtile
    
    Key([mod, "shift"], "Escape", lazy.shutdown()),     # Log off qtile

    Key([mod], "r", lazy.spawncmd()),                   # Open prompt in bar
    #------------------------------------------------------

    # Launch programs--------------------------------------
    Key([mod], "Return", lazy.spawn(terminal)),
    Key([mod], "m", lazy.spawn("firefox")),
    Key([mod], "c", lazy.spawn("code")),
    Key([mod], "n", lazy.spawn("thunar")),
    Key([mod], "v", lazy.spawn("virtualbox")),
    Key([mod], "l", lazy.spawn("libreoffice")),

    Key([mod, "shift"], "Return", lazy.spawn("dmenu_run -p '>>>' -fn 'ohsnap:size=16' -nb '#454545' -nf '#ffffff' -sb '#458588' -sf '#ffffff'")),
    

    # Volume-----------------------------------------------
    Key([], "XF86AudioLowerVolume", lazy.spawn("vol down")),
    Key([],"XF86AudioRaiseVolume", lazy.spawn("vol up")),
    Key([],"XF86AudioMute", lazy.spawn("vol toggle")),

    # Brightness-------------------------------------------
    Key([], "XF86MonBrightnessUp", lazy.spawn("bri up")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("bri down")),

    # Screenshot-------------------------------------------
    Key([mod], "s", lazy.spawn("scrot '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/images/'")),
]