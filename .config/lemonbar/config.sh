#!/bin/sh

bg="#292d3e"
bg_alt="#3e4251"

Format() {
    echo -n " %{+u}%{B$bg_alt} $1 %{B$bg}%{-u} "
}

#===================================================================
Workspaces() {
    local desktops=$(bspc query -D --names)
    local focused=$(bspc query -D --names -d focused)

    icon_list=("  " "  " "  " " 漣 ")

    for i in $desktops; do
        if [[ $i = $focused ]]; then
            echo -n " %{+u}${icon_list[i-1]}%{-u}"
        else
            echo -n " ${icon_list[i-1]}"
        fi
    done
}

#===================================================================
Volume() {
    local volume="$(amixer -c 0 get Master | tail -1 | awk '{print $4}' | sed 's/[^0-9]*//g')"
    Format "墳 ${volume}%"
}

Network() {
    # max quality = 70
    local quality=`iwconfig wlo1 | grep -o "Quality=[1-9]*"`
    let percent=${quality}*100/70

    Format " ${percent}%"
}

Battery() {
    local BAT=$(acpi --battery | cut -d, -f2)
    Format "$BAT"
}

Clock() {
    local DATETIME=$(date "+%a %b %d, %T")
    Format " $DATETIME"
}


showContent() {
    echo -en "%{l}$(Workspaces)%{r}$(Volume)$(Network)$(Battery)$(Clock)"
}

while true; do
    showContent
    sleep 1
done