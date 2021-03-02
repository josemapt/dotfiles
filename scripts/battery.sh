#!/bin/bash

while true; do
    battery_level=`< /sys/class/power_supply/BAT0/capacity`
    battery_status=`< /sys/class/power_supply/BAT0/status`

    if [[ $battery_status = "Charging" && $battery_level -ge 80 ]];
    then
        notify-send "Battery high" "Battery level is ${battery_level}%!"
        canberra-gtk-play -i window-attention
    fi

    if [[ $battery_status = "Discharging" && $battery_level -le 30 ]];
    then
        notify-send "Battery low" "Battery level is ${battery_level}%!"
        canberra-gtk-play -i window-attention
    fi
    sleep 60;
done
