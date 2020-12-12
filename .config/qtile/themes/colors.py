from os import path
import subprocess
import os
import json


def load_theme():

    qtile_path = path.join(path.expanduser('~'), ".config" "/qtile")
    config = path.join(qtile_path, "theme.json")

    with open(config) as f:
        theme = json.load(f)["theme"]

    theme_file = path.join(qtile_path, "themes", f'{theme}.json')

    if not path.isfile(theme_file):

        with open(config, "w") as f:            
            f.write('{"theme": "material_ocean"}')
            os.system("notify-send 'theme not found'")
        
        with open(path.join(qtile_path, "themes/material_ocean.json")) as g:
            return json.load(g)
    
    else:
        with open(theme_file) as f:
            return json.load(f)


colors = load_theme()