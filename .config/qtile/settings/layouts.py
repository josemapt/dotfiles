from libqtile import layout

from themes.colors import colors

layout_style = {
    'margin': 4,
    'border_width': 1,
    'border_normal': colors["inactive"],
    'border_focus': colors["active"],
}

layouts = [
    layout.MonadTall(**layout_style),
]

floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry

    {'wname': 'zoom'},
    {'wmclass': 'zoom'},

    {'wmclass': 'Xephyr'},
    
],border_focus=colors["active"])