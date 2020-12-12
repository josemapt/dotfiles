from libqtile.config import Key
from libqtile.command import lazy

mod = "mod4"
terminal = "alacritty"

keys = [
    # Change focused window
    Key([mod], "Tab",  lazy.layout.next()),

    #-----------------------------------------------------
    Key([mod, "shift"], "q", lazy.window.kill()), # Kill actual window

    Key([mod, "shift"], "r", lazy.restart()), # Restart qtile
    
    Key([mod, "shift"], "Escape", lazy.shutdown()), # Log off qtile

    Key([mod], "r", lazy.spawncmd()), # Open promp in bar
    #------------------------------------------------------

    # Launch programs
    Key([mod], "Return", lazy.spawn(terminal)),
    Key([mod, "shift"], "Return", lazy.spawn("dmenu_run")),
    Key([mod], "m", lazy.spawn("firefox")),
    Key([mod], "c", lazy.spawn("code")),
    Key([mod], "n", lazy.spawn("thunar")),
    Key([mod], "v", lazy.spawn("virtualbox")),
    Key([mod], "l", lazy.spawn("libreoffice")),
    

    # Volume
    Key([], "XF86AudioLowerVolume", lazy.spawn("vol down")),
    Key([],"XF86AudioRaiseVolume", lazy.spawn("vol up")),
    Key([],"XF86AudioMute", lazy.spawn("vol toggle")),

    # Brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn("bri up")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("bri down")),

    # Screenshot
    Key([mod], "s", lazy.spawn("scrot '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/images/'")),
]