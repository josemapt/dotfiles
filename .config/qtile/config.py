from libqtile import hook

import subprocess
from os import path

from settings.groups import groups
from settings.keys import keys
from settings.topbar import widget_defaults, extension_defaults, screens
from settings.mouse import mouse
from settings.layouts import layout_style, layouts, floating_layout


@hook.subscribe.startup_once
def autostart():
    subprocess.call(path.join(path.expanduser('~'), ".config" "/qtile", "autostart.sh"))


dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
wmname = "LG3D"