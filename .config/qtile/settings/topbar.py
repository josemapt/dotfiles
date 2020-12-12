from libqtile import bar, widget
from libqtile.config import Group, Screen

from themes.colors import colors

widget_defaults = dict(
    font='UbuntuMono Nerd Font Bold',
    fontsize=18,
    padding=4,
    background = colors["bg"],
)

extension_defaults = widget_defaults.copy()


# Widgets types -------------------------------------------

def powerline(myFg, myBg):
    return widget.TextBox(
        text = " ",
        fontsize = 37,
        padding = -2,
        foreground = myFg,
        background = myBg
        )


# Widgets --------------------------------------------------

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    fontsize = 35,
                    padding = 10,
                    borderwidth = 2,
                    active = colors["active"],
                    inactive = colors["inactive"],
                    rounded = False,
                    highlight_method = "block",
                    this_current_screen_border = colors["focus"],
                    disable_drag=True,
                    ),

                widget.Prompt(),

                widget.WindowName(
                    fontsize = 12,
                    padding = 18,
                    foreground = colors["active"],
                ),

                widget.Spacer(),

                powerline(colors["color4"], colors["bg"]),

                widget.TextBox(
                    text = " ",
                    fontsize = 18,
                    background = colors["color4"],
                ),

                widget.CheckUpdates(
                    display_format = '{updates}',
                    background = colors["color4"],
                ),

                powerline(colors["color3"], colors["color4"]),

                widget.TextBox(
                    text = "🌡 ",
                    fontsize = 14,
                    background = colors["color3"],
                ),
                
                widget.ThermalSensor(
                    background = colors["color3"],
                ),

                powerline(colors["color2"], colors["color3"]),
                
                widget.TextBox(
                    text = " ",
                    fontsize = 18,
                    background = colors["color2"],
                ),

                widget.CPU(
                    background = colors["color2"],
                ),

                powerline(colors["color1"], colors["color2"]),

                widget.TextBox(
                    text = " ",
                    fontsize = 16,
                    background = colors["color1"],
                ),

                widget.Clock(
                    format = "%A, %B %d  [ %H:%M ]",
                    background = colors["color1"],
                    ),
                
                powerline(colors["bg"], colors["color1"]),
                
                widget.Systray(
                    icon_size = 28,
                    padding = 8,
                ),
            ],
            24,
        ),
    ),
]