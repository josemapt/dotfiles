#!/bin/sh


BORDER="#383C4A"
SEPARATOR="#383C4A"
FOREGROUND="#B0B0B0"
BACKGROUND="#383C4A"
BACKGROUND_ALT="#3C4150"
HIGHLIGHT_BACKGROUND="#476B99"
HIGHLIGHT_FOREGROUND="#FFFFFF"

BLACK="#000000"
WHITE="#ffffff"
RED="#e53935"
GREEN="#43a047"
YELLOW="#fdd835"
BLUE="#1e88e5"
MAGENTA="#00897b"
CYAN="#00acc1"
PINK="#d81b60"
PURPLE="#8e24aa"
INDIGO="#3949ab"
TEAL="#00897b"
LIME="#c0ca33"
AMBER="#ffb300"
ORANGE="#fb8c00"
BROWN="#6d4c41"
GREY="#757575"
BLUE_GREY="#546e7a"
DEEP_PURPLE="#5e35b1"
DEEP_ORANGE="#f4511e"
LIGHT_BLUE="#039be5"
LIGHT_GREEN="#7cb342"


# Launch Rofi
MENU="$(rofi -no-lazy-grab -sep "|" -dmenu -i -p 'Color scheme :' \
-hide-scrollbar true \
-bw 0 \
-lines 2 \
-line-padding 10 \
-padding 10 \
-width 15 \
-xoffset -10 -yoffset +40 \
-location 0 \
-columns 1 \
-font "Fantasque Sans Mono 14" \
-color-enabled true \
-color-window "$BACKGROUND,$BORDER,$SEPARATOR" \
-color-normal "$BACKGROUND_ALT,$FOREGROUND,$BACKGROUND_ALT,$HIGHLIGHT_BACKGROUND,$HIGHLIGHT_FOREGROUND" \
-color-active "$BACKGROUND,$MAGENTA,$BACKGROUND_ALT,$HIGHLIGHT_BACKGROUND,$HIGHLIGHT_FOREGROUND" \
-color-urgent "$BACKGROUND,$YELLOW,$BACKGROUND_ALT,$HIGHLIGHT_BACKGROUND,$HIGHLIGHT_FOREGROUND" \
<<< "Light|Darck")"
case "$MENU" in
  *Light)  sed -i -e 's/bg = .*/bg = #fcfcfc/g' ~/.config/polybar/colors.ini && sed -i -e 's/fg-tittle = .*/fg-tittle = #292d3e/g' ~/.config/polybar/colors.ini && killall polybar && polybar bar1 & ;;
  *Darck)  sed -i -e 's/bg = .*/bg = #292d3e/g' ~/.config/polybar/colors.ini && sed -i -e 's/fg-tittle = .*/fg-tittle = #fcfcfc/g' ~/.config/polybar/colors.ini && killall polybar && polybar bar1 & ;;
esac