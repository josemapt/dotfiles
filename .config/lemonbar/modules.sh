#!/bin/sh

trap 'Update' 5

bg="#292d3e"
bg_alt="#3e4251"

Format() {
    echo -n " %{+u}%{B$bg_alt} $1 %{B$bg}%{-u} "
}

# ACTIVE ===================================================================

Workspaces() {
    local desktops=$(bspc query -D --names)
    local focused=$(bspc query -D --names -d focused)
    local occupied=$(bspc query -D -d .occupied)

    icon_list=("  " "  " "  " " 漣 ")

    for i in $desktops; do
        if [[ $i = $focused ]]; then
            echo -n " %{+u}${icon_list[i-1]}%{-u}"
        else
            echo -n " ${icon_list[i-1]}"
        fi
    done
}


Volume() {
    local volume="$(amixer get Master | grep "%" | cut -c 22-23)"
    Format "墳 ${volume}%"
}

# PASIVE ===================================================================

Clock() {
    local DATETIME=$(date "+%a %b %d, %T")
    Format " $DATETIME"
}

Battery() {
    local BAT=$(acpi --battery | cut -d, -f2)
    Format "$BAT"
}

Network() {
    # max quality = 70
    local quality=`iwconfig wlo1 | grep -o "Quality=[0-9]*"`
    let percent=${quality}*100/70

    Format " ${percent}%"
}

#===================================================================

Update() {
    echo -en "%{l}$(Workspaces)%{r}$(Volume)$(Network)$(Battery)$(Clock)"
}

while true; do
    Update
    sleep 1 &
    wait
done