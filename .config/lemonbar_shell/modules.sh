#!/bin/sh

trap 'Update' 5

bg="#292d3e"
bg_alt="#3e4251"

fg="#ffffff"
fg_alt="#9C9C9C"

red="#ff0000"

Format() {
    echo -n " %{+u}%{B$bg_alt} $1 %{B$bg}%{-u} "
}

# ACTIVE ===================================================================

Workspaces() {
    local desktops=$(bspc query -D --names)
    local focused=$(bspc query -D --names -d focused)
    local occupied=$(bspc query -D --names -d .occupied)

    icon_list=("  " "  " "  " " 漣 ")

    for i in $desktops; do
        if [[ $i = $focused ]]; then
            echo -n " %{+u}${icon_list[i-1]}%{-u}"
        else
            [[ `echo "$occupied" | grep -o $i` ]] && echo -n " ${icon_list[i-1]}" || echo -n " %{F$fg_alt}${icon_list[i-1]}%{F$fg}"
        fi
    done
}


Volume() {
    local volume="$(amixer -M get Master | grep -o "[0-9]*%")"
    Format "墳 ${volume}"
}

# PASIVE ===================================================================

Clock() {
    local DATETIME=$(date "+%a %b %d, %H:%M")
    Format " $DATETIME"
}

Battery() {
    local BAT=`cat /sys/class/power_supply/BAT0/capacity`
    
    case $BAT in
        9*)   Format " $BAT%"    ;;
        8*)   Format " $BAT%"    ;;
        7*)   Format " $BAT%"    ;;
        6*)   Format " $BAT%"    ;;
        5*)   Format " $BAT%"    ;;
        4*)   Format " $BAT%"    ;;
        3*)   Format " $BAT%"    ;;
        2*)   Format "%{F$red} $BAT%{F$fg}%"    ;;
        1*)   Format "%{F$red} $BAT%{F$fg}%"    ;;
        *)  Format "battery not found";;
    esac
}

Network() {
    # max quality = 70
    local quality=`iwconfig wlo1 | grep -o "[0-9]*/70"`
    #let percent=${quality}*100/70

    case $quality in
        0*/70 | 1*/70)   Format ""    ;;
        2*/70 | 3*/70)   Format ""    ;;
        4*/70 | 5*/70)   Format ""    ;;
        6*/70 | 70/70)   Format ""    ;;
        *)  Format "%{F$red}睊%{F$fg}"  ;;
    esac
}

mem() {
    #Format "`free -h | awk '/^Mem:/ {print $3 "/" $2}'`"
    Format " `free -h | awk '/^Mem:/ {print $3}'`"
}

CPU_temp() {
    local core1=`cat /sys/devices/platform/coretemp.0/hwmon/hwmon4/temp2_input`
    local core2=`cat /sys/devices/platform/coretemp.0/hwmon/hwmon4/temp3_input`
    local core3=`cat /sys/devices/platform/coretemp.0/hwmon/hwmon4/temp4_input`
    local core4=`cat /sys/devices/platform/coretemp.0/hwmon/hwmon4/temp5_input`

    let temp=($core1+$core2+$core3+$core4)/4000

    Format " $tempºC"
}

#===================================================================
Update(){
    echo -en "%{l}$(Workspaces)%{r}$(CPU_temp)$(Volume)$(Network)$(Battery)$(Clock)\n"
}

while true; do
    Update > ~/.config/lemonbar/lemonpipe
    sleep 60 &
    wait
done
