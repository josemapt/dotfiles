#!/bin/sh

tail -f ~/.config/lemonbar/lemonpipe | lemonbar -p \
    -g 1920x30+0+0 \
    -F "#ffffff" -B "#292d3e" -U "#aa00ff" -u 3 \
    -f "Ubuntu Mono Nerd Font"-17 -o -2 \
    -f "material\-wifi"-16
